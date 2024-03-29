import random
import string
from datetime import datetime

from flask import Blueprint, request, jsonify
from flask_mail import Message
from sqlalchemy import asc, func, desc

from exts import db, mail
from models.book import Book
from models.booktable import BookTable
from models.captcha import Captcha
from models.lend import Lend
from models.reader import Reader
from models.reserve import Reserve

reader = Blueprint('reader', __name__, url_prefix='/reader')


@reader.route('/captcha/', methods=['POST'])
def captcha():
    data = request.json  # 使用 request.json 获取 POST 请求的 JSON 数据
    # 从 JSON 数据中获取 email 和 password
    email = data.get('email')
    if not email:
        return jsonify({'code': 400, 'message': '参数不完整'})
    reader = Reader.query.filter(Reader.email == email).first()
    if reader:
        return jsonify({'code': 400, 'message': '该邮箱已存在，请前往登录页面'})
    code = ''.join(random.sample(string.digits * 6, 6))
    captcha = Captcha(email=email, code=code)
    if Captcha.query.filter(Captcha.email == email).first():
        Captcha.query.filter(Captcha.email == email).update({'code': code})
        db.session.commit()
    else:
        db.session.add(captcha)
        db.session.commit()
    message = Message(subject='图书管理系统注册验证码', recipients=[email],
                      body='您的验证码是：' + code + "。请尽快登录。")
    mail.send(message)
    return jsonify({'code': 200, 'message': '验证码已发送'})


@reader.route('/register/', methods=['POST'])
def register():
    data = request.json  # 使用 request.json 获取 POST 请求的 JSON 数据
    name = data.get('name')
    password = data.get('password')
    email = data.get('email')
    phone = data.get('phone')
    code = data.get('code')
    if not all([name, password, email, code]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    reader = Reader.query.filter(Reader.email == email).first()
    if reader:
        return jsonify({'code': 400, 'message': '该邮箱已存在'})
    captcha = Captcha.query.filter(Captcha.email == email).first()
    if not captcha or captcha.code != code:
        return jsonify({'code': 400, 'message': '验证码错误'})
    reader = Reader(name=name, password=password, email=email, phone=phone)
    db.session.add(reader)
    db.session.commit()
    return jsonify({'code': 200, 'message': '注册成功'})


@reader.route('/login/', methods=['POST'])
def login():
    data = request.json  # 使用 request.json 获取 POST 请求的 JSON 数据
    # 从 JSON 数据中获取 email 和 password
    email = data.get('email')
    password = data.get('password')
    if not all([email, password]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    reader = Reader.query.filter(Reader.email == email, Reader.password == password).first()
    if not reader:
        return jsonify({'code': 400, 'message': '邮箱或密码错误'})
    return jsonify({'code': 200, 'message': '登录成功', 'email': email, 'reader_id': reader.id})


# 注销函数
@reader.route('/signout/', methods=['POST'])
def signout():
    data = request.json
    read_id = data.get('reader_id')  # 从前端获取
    if not read_id:
        return jsonify({'code': 400, 'message': "参数不完整"})
    reader_id = int(read_id)

    reader = Reader.query.filter(Reader.id == reader_id).first()
    if not reader:
        return jsonify({'code': 400, 'message': '注销失败', 'reason': "读者不存在。请核对自己的读者ID"})
    # 预约记录中全部是有效的记录，读者注销直接级联删除，重点考虑罚金和借阅记录
    if reader.fine > 0:
        return jsonify({'code': 400, 'message': '注销失败',
                        'reason': '罚金尚未缴纳，请及时缴纳！其中罚金会随着时间逐渐增加，请做一名诚信读者！'})
    if reader.borrow_num > 0:
        return jsonify(
            {'code': 400, 'message': '注销失败', 'reason': "你尚存在其余借阅书目。此时不可以注销账户，请及时归还图书。"})
    lend_list = Lend.query.filter(Lend.reader_id == reader_id).all()
    book_count_map = {}  # 未还读书数量
    map = {}  # 未还读书书名
    for lend in lend_list:
        if lend.status == "未还" or lend.status == "超期未还":
            book_id = lend.book_id
            book = Book.query.filter_by(id=book_id).first()
            if book:
                book_name = book.ISBN
                if book_name in book_count_map:
                    book_count_map[book_name] += 1
                else:
                    book_count_map[book_name] = 1
                    booktable = BookTable.query.filter_by(ISBN=book_name).first()
                    map[book_name] = booktable.name

    if not book_count_map:
        db.session.delete(reader)
        db.session.commit()
        return jsonify({'code': 200, 'message': '注销成功！'})
    else:
        reason = '你存在以下借阅的图书信息: ' + ';'.join(
            [f'书名：{map[key]},ISBN编号：{key},借阅数量：{value}本' for key, value in
             book_count_map.items()]) + ".以上图书尚未归还，请尽快归还！若不归还，会处以罚金。请做一名诚信读者！"
        return jsonify({'code': 400, 'message': '注销失败', 'reason': reason})


# 读者查询自己的借阅信息
@reader.route('/checkLend/', methods=['POST'])
def checkLend():
    global lend_info
    data = request.get_json()
    page = int(data.get('page', 1))
    per_page = int(data.get('per_page', 25))
    status = data.get('status')
    reader_id = int(data.get('reader_id'))  # 从前端获取
    lend_info = Lend.query.filter_by(reader_id=reader_id).order_by(asc(func.abs(datetime.now() - Lend.due_date)))
    if status:
        lend_info = lend_info.filter_by(status=status)
    lend_info = lend_info.paginate(page=page, per_page=per_page, error_out=False)

    lend_info_serializable = []
    for lend in lend_info:
        book = Book.query.filter_by(book_id=lend.book_id).first()
        book_table_info = BookTable.query.filter_by(ISBN=book.ISBN).first()

        lend_info_serializable.append({
            'book_name': book_table_info.name,
            'ISBN': book.ISBN,
            'book_id': lend.book_id,
            'version': book_table_info.version,
            'author': book_table_info.author,
            'lend_date': lend.lend_date.strftime('%Y-%m-%d %H:%M:%S'),
            'reader_id': lend.reader_id,
            'publisher': book_table_info.publish,
            'return_date': lend.lend_date.strftime('%Y-%m-%d %H:%M:%S'),
            'due_date': lend.due_date.strftime('%Y-%m-%d %H:%M:%S'),
            'status': lend.status
        })

    return jsonify({'code': 200,
                    'message': '查询成功',
                    'total_count': lend_info.total,
                    'booktables': lend_info_serializable,
                    'page': lend_info.page,
                    'per_page': lend_info.per_page,
                    })


# 分页展示读者的预约记录
@reader.route('/checkreserve/', methods=['POST'])
def checkreserve():
    data = request.get_json()
    page = int(data.get('page', 1))
    per_page = int(data.get('per_page', 25))

    reader_id = data.get('reader_id')  # 从前端获取
    if reader_id:
        reserve_info = Reserve.query.filter_by(reader_id=reader_id).order_by(desc(Reserve.reserve_date))
    else:
        reserve_info = Reserve.query.order_by(desc(Reserve.reserve_date))

    reserve_info = reserve_info.paginate(page=page, per_page=per_page, error_out=False)

    reserve_info_serializable = []
    for reserve in reserve_info:
        book_table_info = BookTable.query.filter_by(ISBN=reserve.ISBN).first()

        reserve_info_serializable.append({
            'book_name': book_table_info.name,
            'ISBN': book_table_info.ISBN,
            'book_id': reserve.book_id,
            'version': book_table_info.version,
            'reader_id': reserve.reader_id,
            'author': book_table_info.author,
            'publisher': book_table_info.publish,
            'reserve_date': reserve.reserve_date.strftime('%Y-%m-%d %H:%M:%S'),
            'book_id': reserve.book_id
        })

    return jsonify({
        'code': 200,
        'message': '查询成功',
        'total_count': reserve_info.total,
        'booktables': reserve_info_serializable,
        'page': reserve_info.page,
        'per_page': reserve_info.per_page
    })
# 返回读者信息
@reader.route('/queryreader1/', methods=['POST'])
def queryreader1():
    data = request.get_json()
    reader_id = data.get('reader_id')
    readers = Reader.query.filter_by(id=reader_id)
    readers_serializable = [
        {
            'id': reader.id,
            'name': reader.name,
            'email': reader.email,
            'phone': reader.phone,
            'fine': reader.fine,
            'borrow_num': reader.borrow_num,
        }
        for reader in readers
    ]
    response = {
        'code': 200,
        'message': '查询成功',
        'reader': readers_serializable,
    }

    return jsonify(response)