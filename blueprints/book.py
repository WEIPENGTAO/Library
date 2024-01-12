import time
from datetime import datetime

from flask import request, jsonify
from flask_mail import Message
from sqlalchemy import and_

from blueprints.manager import manager
from exts import db, mail
from models.book import Book
from models.booktable import BookTable
from models.lend import Lend
from models.reader import Reader
from models.reserve import Reserve


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
    book_id = data.get('book_id')

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
    if not book_id:
        books = Book.query.filter(Book.ISBN.in_(booktable_ISBN_list)).order_by(Book.ISBN).paginate(page=page,
                                                                                                   error_out=False)
    if book_id:
        books = Book.query.filter(Book.ISBN.in_(booktable_ISBN_list), Book.book_id == book_id).order_by(
            Book.ISBN).paginate(page=page, error_out=False)

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
            "manager_by": book.manager_id,
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
        'books': result_list,
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
    num = int(data.get('num', 0))

    if not all([ISBN, location, manager_id]) and num >= 0:
        return jsonify({'code': 400, 'message': '参数不完整'})

    if location == '图书流通室':
        status = '未借出'
    elif location == "图书借阅室":
        status = "不外借"
    else:
        return jsonify({'code': 400, 'message': '图书位置信息不合理。'})
    booktable = BookTable.query.filter(BookTable.ISBN == ISBN).first()
    for i in range(num):  # 逻辑有点讲不通，其实，但是缺少字段，这部分后期商量
        book = Book(ISBN=ISBN, location=location, manager_id=manager_id, status=status,
                    book_id="C" + ISBN[16:19] + "." + str(booktable.num + i))
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
    book = Book.query.filter_by(book_id=book_id).first()
    if book is None:
        return jsonify({'code': 400, 'message': "该图书不存在。"})
    db.session.delete(book)
    db.session.commit()
    return jsonify({'code': 200, 'message': '删除成功！'})


@manager.route('/updatebook/', methods=['POST'])
def updateBook():
    data = request.json
    book_id = data.get('book_id')
    ISBN = data.get('ISBN')
    location = data.get('location')
    manager_id = data.get('manager_id')  # 这个需要从前端获得，只有管理员登录后才行，所以对此字段不考虑外检约束
    if not book_id:
        return jsonify({'code': 400, 'message': '输入空白的图书编号信息！'})
    book = Book.query.filter_by(book_id=book_id).first()
    if book is None:
        return jsonify({'code': 400, 'message': "不存在该图书！"})
    if ISBN:
        if not BookTable.query.filter_by(ISBN=ISBN).first():
            return jsonify({'code': 400, 'message': "无法添加该信息，因为图书表单中不存在该信息。"})
        book.ISBN = ISBN
    if location in ["图书阅览室", "图书流通室"]:
        book.location = location
    if manager_id:
        book.manager_id = manager_id
    db.session.commit()
    return jsonify({'code': 200, 'message': '修改成功！'})


# 借书管理
@manager.route('/borrowbook/', methods=['POST'])
def borrowbook():
    data = request.json
    ISBN = data.get('ISBN')
    reader_id = data.get('reader_id')
    book_id = data.get('book_id')
    due_date = data.get('due_date')
    if not ((reader_id and book_id) or (ISBN and reader_id)):
        return jsonify({'code': 400, 'message': '请提供ISBN、读者ID或者图书ID、读者ID'})
    reader = Reader.query.filter_by(id=reader_id).first()
    if not reader:
        return jsonify({'code': 400, 'message': "读者编号不存在！请注册或核实记录！"})
    if reader.borrow_num >= 10:
        return jsonify({'code': 400, 'message': "读者" + reader.id + "借阅的读书数量已达上限10本。请先归还图书！"})
    if reader.fine > 0:
        return jsonify(
            {'code': 400, 'message': "读者" + reader.id + "尚欠借书违约费用" + reader.fine + "，请先缴纳罚款！"})

    book = None
    if book_id:
        book = Book.query.filter(Book.book_id == book_id, Book.status == '未借出').first()
    if book is None and ISBN:
        book = Book.query.filter(Book.ISBN == ISBN, Book.status == '未借出').first()
    if not book:
        return jsonify({'code': 400, 'message': '该图书不存在或数量不足。'})
    if not due_date:
        return jsonify({'code': 400, 'message': "未提供所借图书应当归还日期。"})

    due_date = datetime.strptime(due_date, '%Y-%m-%d')

    if (due_date - datetime.now()).days > 60:
        return jsonify({'code': 400, 'message': "超过最大借书天数60天。"})

    book.status = '已借出'
    lend = Lend(book_id=book.id, reader_id=reader_id, lend_date=time.strftime('%Y-%m-%d %H:%M:%S', time.localtime()),
                due_date=due_date)
    reader.borrow_num += 1
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
    reader = Reader.query.filter_by(id == reader_id).first()
    lend = Lend.query.filter_by(book_id=book_id, reader_id=reader_id).first()
    if not book:
        return jsonify({'code': 400, 'message': '该图书不存在或未借出!请核对图书编号！'})
    return_date = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())
    fine = 0
    if return_date > lend.due_date:
        fine = (time.time() - time.mktime(time.strptime(book.due_date, '%Y-%m-%d %H:%M:%S'))) / 60 / 60 / 24 * 0.1
    if fine > book.booktable.price:
        fine = book.booktable.price
    reader.fine += fine
    reader.borrow_num -= 1

    if reader.fine > 0:
        message = Message(subject='图书管理系统罚款通知', recipients=[reader.email],
                          body='您尚欠借书违约费用' + str(reader.fine) + '元，请尽快缴纳罚款！')
        mail.send(message)

    book.status = '未借出'
    lend.return_date = return_date
    lend.status = "已还"
    reserve = Reserve.query.filter(Reserve.ISBN == book.ISBN).order_by(Reserve.id.asc()).first()
    if reserve:
        reader = Reader.query.filter_by(reader_id=reserve.reader_id).first()
        booktable = BookTable.query.filter_by(ISBN=book.ISBN).first()
        message = Message(subject='图书管理系统预约通知', recipients=[reader.email],
                          body='您预约的图书《' + booktable.name + '》' + '第' + booktable.version + '版' + booktable.publish + '版。现已存在可借阅图书，请及时借阅!')
        mail.send(message)
    db.session.commit()
    return jsonify({'code': 200, 'message': '还书成功'})
