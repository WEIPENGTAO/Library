from flask import Blueprint, request, jsonify

from exts import db
from models.manager import Manager

manager = Blueprint('manager', __name__, url_prefix='/manager')


@manager.route('/register/', methods=['POST'])
def register():
    # 获取前端传来的数据
    work_num = request.args.get('work_num')
    name = request.args.get('name')
    password = request.args.get('password')
    # 验证数据
    if not all([work_num, name, password]):
        return jsonify({'code': 400, 'message': '参数不完整'})
    # 验证账号是否存在
    manager = Manager.query.filter(Manager.work_num == work_num).first()
    if manager:
        return jsonify({'code': 400, 'message': '该账号已存在'})
    # 保存数据
    manager = Manager(work_num=work_num, name=name, password=password)
    db.session.add(manager)
    db.session.commit()
    return jsonify({'code': 200, 'message': '注册成功'})


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
