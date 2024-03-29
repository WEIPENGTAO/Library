import random
import string

from flask import Blueprint, request, jsonify
from flask_mail import Message

from exts import db, mail
from models.captcha import Captcha
from models.manager import Manager
from models.reader import Reader

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


# 查询读者信息
@manager.route('/queryreader/', methods=['POST'])
def queryreader():
    data = request.get_json()
    page = int(data.get('page', 1))
    per_page = int(data.get('per_page', 10))

    readers = Reader.query.order_by(Reader.id).paginate(page=page, per_page=per_page, error_out=False)

    readers_serializable = []
    for reader in readers:
        readers_serializable.append({
            'id': reader.id,
            'name': reader.name,
            'email': reader.email,
            'phone': reader.phone,
            'fine': reader.fine,
            'borrow_num': reader.borrow_num,
        })

    response = {
        'code': 200,
        'message': '查询成功',
        'total_count': readers.total,
        'readers': readers_serializable,
        'page': readers.page,
        'per_page': readers.per_page
    }

    return jsonify(response)
