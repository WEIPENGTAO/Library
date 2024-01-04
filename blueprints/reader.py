import random
import string

from flask import Blueprint, request, jsonify
from flask_mail import Message

from exts import db, mail
from models.captcha import Captcha
from models.reader import Reader

reader = Blueprint('reader', __name__, url_prefix='/reader')


@reader.route('/captcha/', methods=['POST'])
def captcha():
    email = request.args.get('email')
    if not email:
        return jsonify({'code': 400, 'message': '参数不完整'})
    reader = Reader.query.filter(Reader.email == email).first()
    if reader:
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


@reader.route('/register/', methods=['POST'])
def register():
    name = request.args.get('name')
    password = request.args.get('password')
    email = request.args.get('email')
    code = request.args.get('code')
    if not all([name, password, email, code]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    reader = Reader.query.filter(Reader.email == email).first()
    if reader:
        return jsonify({'code': 400, 'message': '该邮箱已存在'})
    captcha = Captcha.query.filter(Captcha.email == email).first()
    if not captcha or captcha.code != code:
        return jsonify({'code': 400, 'message': '验证码错误'})
    reader = Reader(name=name, password=password, email=email)
    db.session.add(reader)
    return jsonify({'code': 200, 'message': '注册成功'})


@reader.route('/login/', methods=['POST'])
def login():
    email = request.args.get('email')
    password = request.args.get('password')
    print(email, password)
    if not all([email, password]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    reader = Reader.query.filter(Reader.email == email, Reader.password == password).first()
    if not reader:
        return jsonify({'code': 400, 'message': '邮箱或密码错误'})
    return jsonify({'code': 200, 'message': '登录成功', 'email': email})
