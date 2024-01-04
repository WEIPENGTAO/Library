import random
import string

from flask import Blueprint, request, jsonify
from flask_mail import Message

from exts import db, mail
from models.booktable import BookTable
from models.captcha import Captcha
from models.manager import Manager

manager = Blueprint('manager', __name__, url_prefix='/manager')


@manager.route('/register/', methods=['POST'])
def register():
    name = request.args.get('name')
    password = request.args.get('password')
    email = request.args.get('email')
    code = request.args.get('code')
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
    return jsonify({'code': 200, 'message': '注册成功'})


# 获取验证码
@manager.route('/captcha/', methods=['POST'])
def captcha():
    email = request.args.get('email')
    if not email:
        return jsonify({'code': 400, 'message': '参数不完整'})
    manager = Manager.query.filter(Manager.email == email).first()
    if manager:
        return jsonify({'code': 400, 'message': '该邮箱已存在'})
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
    email = request.args.get('email')
    password = request.args.get('password')
    if not all([email, password]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    manager = Manager.query.filter(Manager.email == email).first()
    if not manager:
        return jsonify({'code': 400, 'message': '该邮箱不存在'})
    if manager.password != password:
        return jsonify({'code': 400, 'message': '密码错误'})
    return jsonify({'code': 200, 'message': '登录成功', 'email': email})


# 添加图书表
@manager.route('/addbooktable/', methods=['POST'])
def addbooktable():
    name = request.args.get('name')
    author = request.args.get('author')
    ISBN = request.args.get('ISBN')
    price = request.args.get('price')
    publish = request.args.get('publish')
    pub_date = request.args.get('pub_date')
    manager_id = request.args.get('manager_id')
    num = request.args.get('num')
    version = request.args.get('version')
    if not all([name, author, ISBN, price, publish, pub_date, manager_id, num, version]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    booktable = BookTable(name=name, author=author, ISBN=ISBN, price=price, publish=publish, pub_date=pub_date,
                          manager_id=manager_id, num=num, version=version)
    db.session.add(booktable)
    db.session.commit()
    return jsonify({'code': 200, 'message': '添加成功'})


# 删除图书表
@manager.route('/deletebooktable/', methods=['POST'])
def deletebooktable():
    ISBN = request.args.get('ISBN')
    if not ISBN:
        return jsonify({'code': 400, 'message': '参数不完整'})
    booktable = BookTable.query.filter(BookTable.ISBN == ISBN).first()
    if not booktable:
        return jsonify({'code': 400, 'message': '该图书不存在'})
    db.session.delete(booktable)
    return jsonify({'code': 200, 'message': '删除成功'})


# 修改图书表
@manager.route('/updatebooktable/', methods=['POST'])
def updatebooktable():
    ISBN = request.args.get('ISBN')
    name = request.args.get('name')
    author = request.args.get('author')
    price = request.args.get('price')
    publish = request.args.get('publish')
    pub_date = request.args.get('pub_date')
    manager_id = request.args.get('manager_id')
    num = request.args.get('num')
    version = request.args.get('version')
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
    return jsonify({'code': 200, 'message': '修改成功'})


# 分页展示图书表
@manager.route('/showbooktable/', methods=['POST'])
def showbooktable():
    page = request.args.get('page')
    if not page:
        return jsonify({'code': 400, 'message': '参数不完整'})
    page = int(page)
    booktables = BookTable.query.paginate(page=page, per_page=10, error_out=False)
    booktable_list = []
    for booktable in booktables.items:
        booktable_list.append(booktable.to_dict())
    return jsonify({'code': 200, 'message': '查询成功', 'booktables': booktable_list})
