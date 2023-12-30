import random
import string

from flask import Blueprint, request, jsonify
from flask_mail import Message

from exts import db, mail
from models.captcha import Captcha
from models.manager import Manager

manager = Blueprint('manager', __name__, url_prefix='/manager')


@manager.route('/register/', methods=['POST'])
def register():
    # 获取前端传来的数据
    work_num = request.args.get('work_num')
    name = request.args.get('name')
    password = request.args.get('password')
    email = request.args.get('email')
    code = request.args.get('code')
    # 验证数据
    if not all([work_num, name, password, email, code]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    # 验证邮箱是否存在
    manager = Manager.query.filter(Manager.email == email).first()
    if manager:
        return jsonify({'code': 400, 'message': '该邮箱已存在'})
    captcha = Captcha.query.filter(Captcha.email == email).first()
    if not captcha:
        return jsonify({'code': 400, 'message': '验证码不存在'})
    if captcha.code != code:
        return jsonify({'code': 400, 'message': '验证码错误'})
    # 保存数据
    manager = Manager(work_num=work_num, name=name, password=password, email=email)
    db.session.add(manager)
    db.session.commit()
    return jsonify({'code': 200, 'message': '注册成功'})


# 获取验证码
@manager.route('/captcha/', methods=['POST'])
def captcha():
    # 获取前端传来的数据
    email = request.args.get('email')
    # 验证数据
    if not email:
        return jsonify({'code': 400, 'message': '参数不完整'})
    # 验证邮箱是否存在
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
    # 获取前端传来的数据
    work_num = request.args.get('work_num')
    password = request.args.get('password')
    # 验证数据
    if not all([work_num, password]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    # 验证账号密码
    manager = Manager.query.filter(Manager.work_num == work_num, Manager.password == password).first()
    if not manager:
        return jsonify({'code': 400, 'message': '账号或密码错误'})
    # 保存数据
    return jsonify({'code': 200, 'message': '登录成功'})
