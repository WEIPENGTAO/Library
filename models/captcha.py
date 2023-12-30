from exts import db


# 邮箱验证码
class Captcha(db.Model):
    __tablename__ = 'captcha'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    email = db.Column(db.String(45), primary_key=True)
    code = db.Column(db.String(6), nullable=False)

    def __repr__(self):
        return f"<Captcha(email={self.email}, code={self.code})>"
