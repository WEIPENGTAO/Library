from flask import Blueprint, request, jsonify

from exts import db
from models.reader import Reader

reader = Blueprint('reader', __name__, url_prefix='/reader')


@reader.route('/register/', methods=['POST'])
def register():
    reader_id = request.args.get('reader_id')
    name = request.args.get('name')
    password = request.args.get('password')
    email = request.args.get('email')
    phone = request.args.get('phone')
    sex = request.args.get('sex')

    if not all([reader_id, password]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    reader = Reader.query.filter(Reader.reader_id == reader_id).first()
    if reader:
        return jsonify({'code': 400, 'message': '该账号已存在'})
    reader = Reader(reader_id=reader_id, name=name, password=password, email=email, phone=phone, sex=sex)
    db.session.add(reader)
    db.session.commit()
    return jsonify({'code': 200, 'message': '注册成功'})


@reader.route('/login/', methods=['POST'])
def login():
    reader_id = request.args.get('reader_id')
    password = request.args.get('password')
    if not all([reader_id, password]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    reader = Reader.query.filter(Reader.reader_id == reader_id, Reader.password == password).first()
    if not reader:
        return jsonify({'code': 400, 'message': '账号或密码错误'})
    return jsonify({'code': 200, 'message': '登录成功'})
