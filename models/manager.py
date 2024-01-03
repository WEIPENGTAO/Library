from exts import db


class Manager(db.Model):
    __tablename__ = 'manager'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(20), nullable=False, default=None)
    password = db.Column(db.String(20), nullable=False)
    email = db.Column(db.String(45), nullable=False, unique=True, default=None)
