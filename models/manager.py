from exts import db


class Manager(db.Model):
    __tablename__ = 'manager'

    work_num = db.Column(db.String(20), primary_key=True)
    name = db.Column(db.String(20), nullable=True, default=None)
    password = db.Column(db.String(20), nullable=False)
