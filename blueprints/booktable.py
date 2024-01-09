from flask import request, jsonify

from blueprints.manager import manager
from exts import db
from models.booktable import BookTable
from models.book import Book


# 增加图书表
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
    if booktable.num > 0:
        return jsonify({'code': 400, 'message': '图书表中尚且存在相关的图书，不允许直接删除书目。'})
    db.session.delete(booktable)
    db.session.commit()
    return jsonify({'code': 200, 'message': '删除成功'})


# 修改图书表
@manager.route('/updatebooktable/', methods=['POST'])
def updatebooktable():
    data = request.json  # 使用 request.json 获取 POST 请求的 JSON 数据
    old_ISBN = data.get('old_ISBN')
    ISBN = data.get('ISBN')
    name = data.get('name')
    author = data.get('author')
    price = data.get('price')
    publish = data.get('publish')
    pub_date = data.get('pub_date')
    manager_id = data.get('manager_id')
    num = data.get('num')
    version = data.get('version')
    if not old_ISBN:
        return jsonify({'code': 400, 'message': '没有ISBN，无法锁定图书表目信息。'})
    booktable = BookTable.query.filter(BookTable.ISBN == ISBN).first()
    if not booktable:
        return jsonify({'code': 400, 'message': '该ISBN信息图书不存在！'})
    if ISBN:
        booktable.ISBN = ISBN
    if name:
        booktable.name = name
    if author:
        booktable.author = author
    if price:
        booktable.price = price
    if publish:
        booktable.publish = publish
    if pub_date:
        booktable.pub_date = pub_date
    if manager_id:
        booktable.manager_id = manager_id
    if num:
        booktable.num = num
    if version:
        booktable.version = version
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
    for booktable in booktables.items:
        booktable_list.append(
            {'id': booktable.id, 'ISBN': booktable.ISBN, 'name': booktable.name, 'author': booktable.author,
             'price': booktable.price, 'publish': booktable.publish, 'pub_date': booktable.pub_date,
             'manager_id': booktable.manager_id, 'num': booktable.num, 'version': booktable.version})

    return jsonify({'code': 200,
                    'message': '查询成功',
                    'total_count': booktables.total,
                    'booktables': booktable_list,
                    'page': booktables.page,
                    'per_page': booktables.per_page,
                    })

#查询图书表单
@manager.route('/querybooktable/', methods=['POST'])
def querybooktable():
    data = request.get_json()
    ISBN = data.get('ISBN')
    if not ISBN:
        return jsonify({'code': 400, 'message': '参数不完整'})

    item = BookTable.query.filter_by(ISBN=ISBN).first()
    if not item:
        return jsonify({'code': 400, 'message': '不存在该条图书信息。'})

    books=Book.query.filter_by(ISBN=ISBN, status="未借出")
    remain_list=[]
    count=0
    for book in books:
        count+=1
        remain_list.append(book.book_id)

    result_list = [
        {
            'name': item.name,
            'ISBN': item.ISBN,
            'author': item.author,
            'version': item.version,
            'publish': item.publish,
            'num': item.num
        }
    ]
    return jsonify({'code': 200, 'message': result_list, 'remain_book_id': remain_list,'remaining': count})


