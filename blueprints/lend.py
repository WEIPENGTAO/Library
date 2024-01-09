import time
from datetime import datetime

from flask import request, jsonify
from flask_mail import Message
from sqlalchemy import and_, asc, func

from blueprints.manager import manager
from exts import mail
from models.book import Book
from models.booktable import BookTable
from models.lend import Lend


# 分页展示管理员查询读者的借阅信息
@manager.route('/querylend/', methods=['POST'])
def checkLend():
    data = request.get_json()
    page = int(data.get('page', 1))
    per_page = int(data.get('per_page', 25))
    status = data.get('status')  # 从前端获取，可选参数
    reader_id = data.get('reader_id')  # 从前端获取，可选参数

    if status and status not in ["超期未还", "未还", "已还"]:
        return jsonify({'code': 400, 'message': '状态错误'})

    conditions = []
    if status:
        conditions.append(Lend.status == status)

    if reader_id:
        conditions.append(Lend.reader_id == reader_id)

    if not conditions:
        lend_info = Lend.query.order_by(asc(func.abs(datetime.now() - Lend.due_date)))
    else:
        lend_info = Lend.query.filter(and_(*conditions)).order_by(asc(func.abs(datetime.now() - Lend.due_date)))

    lend_info = lend_info.paginate(page=page, per_page=per_page, error_out=False)

    lend_info_serializable = []
    for lend in lend_info:
        book = Book.query.filter_by(id=lend.book_id).first()

        book_table_info = BookTable.query.filter_by(ISBN=book.ISBN).first()

        lend_info_serializable.append({
            'book_name': book_table_info.name,
            'reader_id': lend.reader_id,
            'ISBN': book_table_info.ISBN,
            'book_id': book.book_id,
            'version': book_table_info.version,
            'author': book_table_info.author,
            'publisher': book_table_info.publish,
            'return_date': lend.lend_date.strftime('%Y-%m-%d %H:%M:%S'),
            'due_date': lend.due_date.strftime('%Y-%m-%d %H:%M:%S'),
            'status': lend.status
        })

    return jsonify({
        'code': 200,
        'message': '查询成功',
        'total_count': lend_info.total,
        'booktables': lend_info_serializable,
        'page': lend_info.page,
        'per_page': lend_info.per_page,
    })


# 还书提醒
@manager.route('/returnnotice/', methods=['POST'])
def returnnotice():
    lends = Lend.query.filter(Lend.due_date < time.strftime('%Y-%m-%d %H:%M:%S', time.localtime()),
                              Lend.status == '未归还').all()
    for lend in lends:
        reader = lend.reader
        book = lend.book
        message = Message(subject='图书管理系统通知', recipients=[reader.email],
                          body='您借阅的图书《' + book.booktable.name + '》已到期，请及时归还')
        mail.send(message)
    return jsonify({'code': 200, 'message': '提醒成功'})
