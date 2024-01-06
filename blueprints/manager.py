import random
import string
import time

from flask import Blueprint, request, jsonify
from flask_mail import Message
from sqlalchemy import and_

from exts import db, mail, scheduler
from models.book import Book
from models.booktable import BookTable
from models.captcha import Captcha
from models.lend import Lend
from models.manager import Manager
from models.reserve import Reserve

manager = Blueprint('manager', __name__, url_prefix='/manager')


@scheduler.task('cron', id='do_job_1', day='*', hour='0', minute='0', second='0')
def job1():
    # 1.对于已到期且未归还的图书，系统通过Email自动通知读者
    lends = Lend.query.filter(Lend.due_date < time.strftime('%Y-%m-%d %H:%M:%S', time.localtime()),
                              Lend.status == '未归还').all()
    for lend in lends:
        reader = lend.reader
        book = lend.book
        message = Message(subject='图书管理系统通知', recipients=[reader.email],
                          body='您借阅的图书《' + book.booktable.name + '》已到期，请及时归还')
        mail.send(message)
    # 2.若读者预约的书已到，系统则自动通过Email通知该读者来办理借书手续。
    reserves = Reserve.query.filter().all()
    for reserve in reserves:
        reader = reserve.reader
        booktable = reserve.booktable
        message = Message(subject='图书管理系统通知', recipients=[reader.email],
                          body='您预约的图书《' + booktable.name + '》已到，请及时借阅')
        mail.send(message)
    # 3.若预约已超时，则自动删除该预约记录。
    reserves = Reserve.query.filter(
        time.strftime('%Y-%m-%d %H:%M:%S', time.localtime()) - Reserve.reserve_date > Reserve.reserve_deadline).all()
    for reserve in reserves:
        reserve.delete()
    # 4.校对图书数量
    booktables = BookTable.query.all()
    ISBN_list = []
    for booktable in booktables:
        ISBN_list.append(booktable.ISBN)
    # 更新图书数量
    for ISBN in ISBN_list:
        booktable = BookTable.query.filter(BookTable.ISBN == ISBN).first()
        booktable.num = Book.query.filter(Book.ISBN == ISBN).count()
    db.commit()


@manager.route('/register/', methods=['POST'])
def register():
    data = request.json  # 使用 request.json 获取 POST 请求的 JSON 数据
    name = data.get('name')
    password = data.get('password')
    email = data.get('email')
    code = data.get('code')
    if not all([name, password, email, code]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    manager = Manager.query.filter(Manager.email == email).first()
    if manager:
        return jsonify({'code': 400, 'message': '该邮箱已存在'})
    captcha = Captcha.query.filter(Captcha.email == email).first()
    if not captcha or captcha.code != code:
        return jsonify({'code': 400, 'message': '验证码错误'})
    manager = Manager(name=name, password=password, email=email)
    db.session.add(manager)
    db.session.commit()
    return jsonify({'code': 200, 'message': '注册成功'})


# 获取验证码
@manager.route('/captcha/', methods=['POST'])
def captcha():
    data = request.json  # 使用 request.json 获取 POST 请求的 JSON 数据
    email = data.get('email')
    if not email:
        return jsonify({'code': 400, 'message': '参数不完整'})
    code = ''.join(random.sample(string.digits * 6, 6))
    captcha = Captcha(email=email, code=code)
    if Captcha.query.filter(Captcha.email == email).first():
        Captcha.query.filter(Captcha.email == email).update({'code': code})
        db.session.commit()
    else:
        db.session.add(captcha)
        db.session.commit()
    message = Message(subject='图书管理系统注册验证码', recipients=[email], body='您的验证码是：' + code)
    mail.send(message)
    return jsonify({'code': 200, 'message': '验证码已发送'})


@manager.route('/login/', methods=['POST'])
def login():
    data = request.json  # 使用 request.json 获取 POST 请求的 JSON 数据
    email = data.get('email')
    password = data.get('password')
    if not all([email, password]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    manager = Manager.query.filter(Manager.email == email).first()
    if not manager:
        return jsonify({'code': 400, 'message': '该邮箱不存在'})
    if manager.password != password:
        return jsonify({'code': 400, 'message': '密码错误'})
    return jsonify({'code': 200, 'message': '登录成功', 'email': email, 'manager_id': manager.id})


# 登出
@manager.route('/logout/', methods=['POST'])
def logout():
    data = request.json
    email = data.get('email')
    if not email:
        return jsonify({'code': 400, 'message': '参数不完整'})
    manager = Manager.query.filter(Manager.email == email).first()
    if not manager:
        return jsonify({'code': 400, 'message': '该邮箱不存在'})
    return jsonify({'code': 200, 'message': '登出成功', 'email': email})


# 通过验证码修改密码
@manager.route('/updatepassword/', methods=['POST'])
def updatepassword():
    data = request.json
    email = data.get('email')
    code = data.get('code')
    password = data.get('password')
    if not all([email, code, password]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    manager = Manager.query.filter(Manager.email == email).first()
    if not manager:
        return jsonify({'code': 400, 'message': '该邮箱不存在'})
    captcha = Captcha.query.filter(Captcha.email == email).first()
    if not captcha or captcha.code != code:
        return jsonify({'code': 400, 'message': '验证码错误'})
    manager.password = password
    db.session.commit()
    return jsonify({'code': 200, 'message': '修改成功'})


# 添加图书表
@manager.route('/addbooktable/', methods=['POST'])
def addbooktable():
    data = request.json  # 使用 request.json 获取 POST 请求的 JSON 数据
    name = data.get('name')
    author = data.get('author')
    ISBN = data.get('ISBN')
    price = data.get('price')
    publish = data.get('publish')
    pub_date = data.get('pub_date')
    manager_id = data.get('manager_id')
    version = data.get('version')
    if not all([name, author, ISBN, price, publish, pub_date, manager_id, version]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    if BookTable.query.filter(BookTable.ISBN == ISBN).first():
        return jsonify({'code': 400, 'message': '该图书已存在'})
    booktable = BookTable(name=name, author=author, ISBN=ISBN, price=price, publish=publish, pub_date=pub_date,
                          manager_id=manager_id, num=0, version=version)
    db.session.add(booktable)
    db.session.commit()
    return jsonify({'code': 200, 'message': '添加成功'})


# 删除图书表
@manager.route('/deletebooktable/', methods=['POST'])
def deletebooktable():
    data = request.json  # 使用 request.json 获取 POST 请求的 JSON 数据
    ISBN = data.get('ISBN')
    if not ISBN:
        return jsonify({'code': 400, 'message': '参数不完整'})
    booktable = BookTable.query.filter(BookTable.ISBN == ISBN).first()
    if not booktable:
        return jsonify({'code': 400, 'message': '该图书不存在'})
    db.session.delete(booktable)
    db.session.commit()
    return jsonify({'code': 200, 'message': '删除成功'})


# 修改图书表
@manager.route('/updatebooktable/', methods=['POST'])
def updatebooktable():
    data = request.json  # 使用 request.json 获取 POST 请求的 JSON 数据
    ISBN = data.get('ISBN')
    name = data.get('name')
    author = data.get('author')
    price = data.get('price')
    publish = data.get('publish')
    pub_date = data.get('pub_date')
    manager_id = data.get('manager_id')
    num = data.get('num')
    version = data.get('version')
    booktable = BookTable.query.filter(BookTable.ISBN == ISBN).first()
    if not booktable:
        return jsonify({'code': 400, 'message': '该图书表单不存在！'})
    if ISBN:
        booktable.ISBN = ISBN
    elif name:
        booktable.name = name
    elif author:
        booktable.author = author
    elif publish:
        booktable.publish = publish
    elif pub_date :
        booktable.pub_date =pub_date
    elif manager_id:
        booktable.manager_id = manager_id
    elif version:
        booktable.version = version
    elif num>=0:
        booktable.num = num
    else:
        return jsonify({'code': 400, 'message': '无修改信息！'})

    db.session.commit()
    return jsonify({'code': 200, 'message': '修改成功'})


# 分页展示图书表,增加默认字段，可以不强制输入参数
@manager.route('/showbooktable/', methods=['POST'])
def showbooktable():
    # 获取分页参数，如果请求中没有指定，则使用默认值
    data = request.get_json()
    page = int(data.get('page', 1))  # 默认值为1
    per_page = int(data.get('per_page', 20))  # 默认值为20
    booktables = BookTable.query.paginate(page=page, per_page=per_page, error_out=False)
    booktable_list = []
    # 查询BookTable的总数
    total_count = BookTable.query.count()
    for booktable in booktables.items:
        booktable_list.append(
            {'id': booktable.id, 'ISBN': booktable.ISBN, 'name': booktable.name, 'author': booktable.author,
             'price': booktable.price, 'publish': booktable.publish, 'pub_date': booktable.pub_date,
             'manager_id': booktable.manager_id, 'num': booktable.num, 'version': booktable.version})

    return jsonify({'code': 200,
                    'message': '查询成功',
                    'total_count': booktables.total,
                    'booktables': booktable_list,
                    'page':  booktables.page,
                    'per_page': booktables.per_page,
                    })















# 根据ISBN查询图书信息,添加分页查询和模糊查询功能,可以兼容以前的版本
@manager.route('/querybook/', methods=['POST'])
def querybook():
    # 获取分页参数
    data = request.get_json()
    page = int(data.get('page', 1))
    per_page = int(data.get('per_page', 20))
    # 获取查询参数
    name = data.get('name')
    author = data.get('author')
    version = data.get('version')
    publish = data.get('publish')
    ISBN = data.get('ISBN')

    # 构建查询条件
    conditions = []
    if name:
        conditions.append(BookTable.name.ilike(f'%{name}%'))
    if author:
        conditions.append(BookTable.author.ilike(f'%{author}%'))
    if version:
        conditions.append(BookTable.version.ilike(f'%{version}%'))
    if publish:
        conditions.append(BookTable.publish.ilike(f'%{publish}%'))
    if ISBN:
        conditions.append(BookTable.ISBN.ilike(f'%{ISBN}%'))

    # 查询 BookTable 表格
    booktables = BookTable.query.filter(and_(*conditions)).all()
    print(booktables)
    # 判断是否找到符合条件的书籍
    if not booktables:
        return jsonify({'code': 400, 'message': '没有找到符合条件的书籍'})

    # 获取 ISBN 属性列表
    booktable_ISBN_list = [booktable.ISBN for booktable in booktables]

    books = Book.query.filter(Book.ISBN.in_(booktable_ISBN_list)).order_by(Book.ISBN).paginate(page=page,
                                                                                             per_page=per_page,
                                                                                              error_out=False)
    result_list = [
        {
            'name': booktable.name,
            'ISBN': booktable.ISBN,
            'author': booktable.author,
            'version': booktable.version,
            'publish': booktable.publish,
            'num': booktable.num,
            'book_id': book.book_id,
            'location': book.location,
            'status': book.status if book else None
        }
        for booktable in booktables
        for book in books
        if book.ISBN == booktable.ISBN
    ]
    # 构造响应数据
    response = {
        'code': 200,
        'message': '查询成功',
        'books':result_list,
        'total_count': books.total,
        'page': books.page,
        'per_page': books.per_page
    }

    return jsonify(response)




# 入库管理
@manager.route('/addbook/', methods=['POST'])
def addbook():
    data = request.json
    ISBN = data.get('ISBN')
    location = data.get('location')
    manager_id = data.get('manager_id')
    num = int(data.get('num',0))

    if not all([ISBN, location, manager_id])  and num>=0:
        return jsonify({'code': 400, 'message': '参数不完整'})
    status = '不外借'
    if location == '图书流通室':
        status = '未借出'
    booktable = BookTable.query.filter(BookTable.ISBN == ISBN).first()
    for i in range(num):                                                         #逻辑有点讲不通，其实，但是缺少字段，这部分后期商量
        book = Book(ISBN=ISBN, location=location, manager_id=manager_id, status=status,book_id="C"+ISBN[16:19]+"."+str(booktable.num+i))
        db.session.add(book)

    booktable.num += num
    db.session.commit()
    return jsonify({'code': 200, 'message': '入库成功'})

@manager.route('/deletebook/', methods=['POST'])
def deletebook():
    data = request.json
    book_id = data.get('book_id')
    if not all([book_id]):
        return jsonify({'code': 400, 'message': "输入空的图书编号"})
    book=Book.query.filter_by(book_id=book_id).first()
    if book is None:
        return jsonify({'code':400,'message':"该图书不存在。"})
    db.session.delete(book)
    db.session.commit()
    return jsonify({'code': 200, 'message': '删除成功！'})

@manager.route('/updatebook/', methods=['POST'])
def updateBook():
    data = request.json
    book_id = data.get('book_id')
    ISBN = data.get('ISBN')
    location = data.get('location')
    manager_id = data.get('manager_id')#这个需要从前端获得，只有管理员登录后才行，所以对此字段不考虑外检约束
    if not book_id :
        return jsonify({'code': 400, 'message': '输入空白的图书编号信息！'})
    book = Book.query.filter_by(book_id=book_id).first()
    if book is None:
        return jsonify({'code': 400,'message':"不存在该图书！"})
    if ISBN:
        if not BookTable.query.filter_by(ISBN=ISBN).first():
            return jsonify({'code':400,'message':"无法添加该信息，因为图书表单中不存在该信息。"})
        book.ISBN = ISBN
    elif location in ["图书阅览室","图书流通室"]:
        book.location = location
    elif manager_id:
        book.manager_id = manager_id
    else:
        return jsonify({'code': 400, 'message': "无修改信息！"})
    db.session.commit()
    return  jsonify({'code': 200, 'message': '修改成功！'})































# 预约管理
@manager.route('/reservebook/', methods=['POST'])
def reservebook():
    data = request.json
    ISBN = data.get('ISBN')
    reader_id = data.get('reader_id')
    reserve_deadline = data.get('reserve_deadline')
    if not all([ISBN, reader_id, reserve_deadline]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    reserve_date = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())
    reserve = Reserve(ISBN=ISBN, reader_id=reader_id, reserve_date=reserve_date, reserve_deadline=reserve_deadline)
    db.session.add(reserve)
    db.session.commit()
    return jsonify({'code': 200, 'message': '预约成功'})







# 借书管理
@manager.route('/borrowbook/', methods=['POST'])
def borrowbook():
    data = request.json
    ISBN = data.get('ISBN')
    reader_id = data.get('reader_id')
    book_id = data.get('book_id')
    if not all([ISBN, reader_id]) and not all([reader_id, book_id]):
        return jsonify({'code': 400, 'message': '请提供ISBN、读者ID或者图书ID、读者ID'})
    book = None
    if book_id:
        book = Book.query.filter(Book.id == book_id, Book.status == '未借出').first()
    if not book and ISBN:
        book = Book.query.filter(Book.ISBN == ISBN, Book.status == '未借出').first()
    if not book:
        return jsonify({'code': 400, 'message': '该图书不存在或数量不足'})
    book.status = '已借出'
    lend = Lend(book_id=book.id, reader_id=reader_id, lend_date=time.strftime('%Y-%m-%d %H:%M:%S', time.localtime()),
                due_date=time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time() + 60 * 60 * 24 * 60)))
    db.session.add(lend)
    db.session.commit()
    return jsonify({'code': 200, 'message': '借阅成功'})


# 还书管理
@manager.route('/returnbook/', methods=['POST'])
def returnbook():
    data = request.json
    book_id = data.get('book_id')
    reader_id = data.get('reader_id')
    if not all([book_id, reader_id]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    book = Book.query.filter(Book.id == book_id, Book.status == '已借出').first()
    if not book:
        return jsonify({'code': 400, 'message': '该图书不存在或未借出'})
    return_date = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())
    fine = 0
    if return_date > book.due_date:
        fine = (time.time() - time.mktime(time.strptime(book.due_date, '%Y-%m-%d %H:%M:%S'))) / 60 / 60 / 24 * 0.1
    book.status = '未借出'
    reader = book.reader
    reader.fine += fine
    ISBN = book.ISBN
    reserve = Reserve.query.filter(Reserve.ISBN == ISBN).first()
    if reserve:
        reader = reserve.reader
        message = Message(subject='图书管理系统预约通知', recipients=[reader.email],
                          body='您预约的图书《' + book.booktable.name + '》已归还，请及时借阅')
        mail.send(message)
    db.session.commit()
    return jsonify({'code': 200, 'message': '还书成功'})
