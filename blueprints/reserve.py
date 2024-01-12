import time

from flask import request, jsonify
from flask_mail import Message
from sqlalchemy import desc

from blueprints.manager import manager
from exts import db
from exts import mail
from models.booktable import BookTable
from models.reserve import Reserve


# 分页展示管理员查询读者的预约记录
@manager.route('/queryreserve/', methods=['POST'])
def queryreserve():
    data = request.get_json()
    page = int(data.get('page', 1))
    per_page = int(data.get('per_page', 25))

    reader_id = data.get('reader_id')  # 从前端获取，可选参数

    if reader_id:
        reserve_info = Reserve.query.filter_by(reader_id=reader_id).order_by(desc(Reserve.reserve_date))
    else:
        reserve_info = Reserve.query.order_by(desc(Reserve.reserve_date))

    reserve_info = reserve_info.paginate(page=page, per_page=per_page, error_out=False)

    reserve_info_serializable = []
    for reserve in reserve_info:
        book_table_info = BookTable.query.filter_by(ISBN=reserve.booktable_ISBN).first()

        reserve_info_serializable.append({
            'book_name': book_table_info.name,
            'ISBN': book_table_info.ISBN,
            'book_id': reserve.book_id,
            "reader_id": reserve.reader_id,
            'version': book_table_info.version,
            'author': book_table_info.author,
            'publisher': book_table_info.publish,
            'reserve_id': reserve.id,
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
    if reserve_deadline > 10 or reserve_deadline < 1:
        return jsonify({'code': 400, 'message': '预约天数应在[1,10]之间'})
    reserve = Reserve(ISBN=ISBN, reader_id=reader_id, reserve_date=reserve_date, reserve_deadline=reserve_deadline)
    db.session.add(reserve)
    db.session.commit()
    return jsonify({'code': 200, 'message': '预约成功'})


# 预约到书提醒
@manager.route('/reservenotice/', methods=['POST'])
def reservenotice():
    reserves = Reserve.query.filter().all()
    for reserve in reserves:
        reader = reserve.reader
        booktable = reserve.booktable
        message = Message(subject='图书管理系统通知', recipients=[reader.email],
                          body='您预约的图书《' + booktable.name + '》已到，请及时借阅')
        mail.send(message)
    return jsonify({'code': 200, 'message': '提醒成功'})


# 删除一条预约记录
@manager.route('/deletereserve/', methods=['POST'])
def deletereserve():
    data = request.json
    id = data.get('id')
    if not id:
        return jsonify({'code': 400, 'message': '请提供记录id'})
    reserve = Reserve.query.filter_by(id=id).first()
    if not reserve:
        return jsonify({'code': 400, 'message': '预约记录不存在'})
    db.session.delete(reserve)
    db.session.commit()
    return jsonify({'code': 200, 'message': '删除成功'})


# 删除过期预约
@manager.route('/deleteexpiredreserve/', methods=['POST'])
def deleteexpiredreserve():
    reserves = Reserve.query.filter(
        time.strftime('%Y-%m-%d %H:%M:%S', time.localtime()) - Reserve.reserve_date > Reserve.reserve_deadline).all()
    for reserve in reserves:
        db.session.delete(reserve)
    db.session.commit()
    return jsonify({'code': 200, 'message': '删除成功'})
