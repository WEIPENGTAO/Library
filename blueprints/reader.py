import random
import string

from flask import Blueprint, request, jsonify
from flask_mail import Message
from sqlalchemy import case
from exts import db, mail
from models.captcha import Captcha
from models.reader import Reader
from models.lend import Lend


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
    message = Message(subject='图书管理系统注册验证码', recipients=[email], body='您的验证码是：' + code+"。请尽快登录。")
    mail.send(message)
    return jsonify({'code': 200, 'message': '验证码已发送'})


@reader.route('/register/', methods=['POST'])
def register():
    data = request.json  # 使用 request.json 获取 POST 请求的 JSON 数据
    name = data.get('name')
    password = data.get('password')
    email = data.get('email')
    code = data.get('code')
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
    data = request.json  # 使用 request.json 获取 POST 请求的 JSON 数据
    # 从 JSON 数据中获取 email 和 password
    email = data.get('email')
    password = data.get('password')
    if not all([email, password]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    reader = Reader.query.filter(Reader.email == email, Reader.password == password).first()
    if not reader:
        return jsonify({'code': 400, 'message': '邮箱或密码错误'})
    return jsonify({'code': 200, 'message': '登录成功', 'email': email})

#读者查询自己的借阅信息
@reader.route('checkLendInfo', methods=['POST'])
def checkLendInfo():
      data = request.json
      reader_id=data.get('reader_id')
      lend_info = Lend.query.filter_by(reader_id=reader_id).order_by(
          case(
              [
                  (Lend.status == '超期未还', 0),
                  (Lend.status == '未还', 1),
                  (Lend.status == '已还', 2)
              ],
              else_=3  # 默认情况下按照借阅时间升序排列
          ),
          case(
              [
                  (Lend.status == '超期未还', Lend.due_time.asc()),
                  (Lend.status == '未还', Lend.due_time.desc())
              ],
              else_=Lend.due_time.asc()  # 默认情况下按照借阅时间升序排列
          )
      ).all()

      return jsonify(lend_info)




