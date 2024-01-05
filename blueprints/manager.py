import random
import string
import time

from flask import Blueprint, request, jsonify
from flask_mail import Message

from exts import db, mail
from models.book import Book
from models.booktable import BookTable
from models.captcha import Captcha
from models.lend import Lend
from models.manager import Manager
from models.reserve import Reserve

manager = Blueprint('manager', __name__, url_prefix='/manager')


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
    if not all([ISBN, name, author, price, publish, pub_date, manager_id, num, version]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    booktable = BookTable.query.filter(BookTable.ISBN == ISBN).first()
    if not booktable:
        return jsonify({'code': 400, 'message': '该图书不存在'})
    booktable.name = name
    booktable.author = author
    booktable.price = price
    booktable.publish = publish
    booktable.pub_date = pub_date
    booktable.manager_id = manager_id
    booktable.num = num
    booktable.version = version
    db.session.commit()
    return jsonify({'code': 200, 'message': '修改成功'})


# 校对图书数量
@manager.route('/checkbooktable/', methods=['POST'])
def checkbooktable():
    # 得到所有图书的ISBN
    booktables = BookTable.query.all()
    ISBN_list = []
    for booktable in booktables:
        ISBN_list.append(booktable.ISBN)
    # 更新图书数量
    for ISBN in ISBN_list:
        booktable = BookTable.query.filter(BookTable.ISBN == ISBN).first()
        booktable.num = Book.query.filter(Book.ISBN == ISBN).count()
    db.session.commit()
    return jsonify({'code': 200, 'message': '校对成功'})


# 分页展示图书表
@manager.route('/showbooktable/', methods=['POST'])
def showbooktable():
    data = request.json  # 使用 request.json 获取 POST 请求的 JSON 数据
    page = data.get('page')
    if not page:
        return jsonify({'code': 400, 'message': '参数不完整'})
    page = int(page)
    booktables = BookTable.query.paginate(page=page, per_page=20, error_out=False)
    booktable_list = []
    for booktable in booktables.items:
        booktable_list.append(
            {'ISBN': booktable.ISBN, 'name': booktable.name, 'author': booktable.author, 'price': booktable.price,
             'publish': booktable.publish, 'pub_date': booktable.pub_date, 'manager_id': booktable.manager_id,
             'num': booktable.num, 'version': booktable.version})
    return jsonify({'code': 200, 'message': '查询成功', 'booktables': booktable_list})


# 根据ISBN查询图书信息
@manager.route('/querybook/', methods=['POST'])
def querybook():
    data = request.json
    ISBN = data.get('ISBN')
    if not ISBN:
        return jsonify({'code': 400, 'message': '参数不完整'})
    books = Book.query.filter(Book.ISBN == ISBN).all()
    book_list = []
    for book in books:
        book_list.append(
            {'id': book.id, 'ISBN': book.ISBN, 'location': book.location, 'manager_id': book.manager_id,
             'status': book.status})
    return jsonify({'code': 200, 'message': '查询成功', 'books': book_list})


# 入库管理
@manager.route('/addbook/', methods=['POST'])
def addbook():
    data = request.json
    ISBN = data.get('ISBN')
    location = data.get('location')
    manager_id = data.get('manager_id')
    num = data.get('num')
    if not all([ISBN, location, manager_id, num]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    status = '不外借'
    if location == '图书流通室':
        status = '未借出'
    for i in range(num):
        book = Book(ISBN=ISBN, location=location, manager_id=manager_id, status=status)
        db.session.add(book)
    booktable = BookTable.query.filter(BookTable.ISBN == ISBN).first()
    booktable.num += num
    db.session.commit()
    return jsonify({'code': 200, 'message': '入库成功'})


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
    if not all([ISBN, reader_id]):
        return jsonify({'code': 400, 'message': '参数不完整'})
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
    reserve = Reserve.query.filter(Reserve.ISBN == ISBN, Reserve.status == '预约未失效').first()
    if reserve:
        reserve.status = '预约已失效'
        reader = reserve.reader
        message = Message(subject='图书管理系统预约通知', recipients=[reader.email],
                          body='您预约的图书《' + book.booktable.name + '》已归还，请及时借阅')
        mail.send(message)
    db.session.commit()
    return jsonify({'code': 200, 'message': '还书成功'})


# 通知管理
@manager.route('/notice/', methods=['POST'])
def notice():
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
    reserves = Reserve.query.filter(Reserve.status == '预约未失效').all()
    for reserve in reserves:
        reader = reserve.reader
        booktable = reserve.booktable
        message = Message(subject='图书管理系统通知', recipients=[reader.email],
                          body='您预约的图书《' + booktable.name + '》已到，请及时借阅')
        mail.send(message)
    return jsonify({'code': 200, 'message': '通知成功'})
