from exts import db


# 邮箱验证码
class Captcha(db.Model):
    __tablename__ = 'captcha'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    email = db.Column(db.String(45), nullable=False, unique=True)
    code = db.Column(db.String(6), nullable=False)
