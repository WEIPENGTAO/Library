from exts import db


class Reader(db.Model):
    __tablename__ = 'reader'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(100), nullable=False, default=None)
    password = db.Column(db.String(20), nullable=False, default='123456')
    email = db.Column(db.String(100), nullable=False, unique=True, default=None)
    sex = db.Column(db.String(1), nullable=False, default=None)
    fine = db.Column(db.DECIMAL(6, 2), nullable=False, default=0.00)
    borrow_num = db.Column(db.Integer, nullable=False, default=0,
                           comment='一名读者最多只能借阅十本图书，且每本图书最多只能借两个月')

    __table_args__ = (
        db.CheckConstraint('fine >= 0', name='check_fine'),
        db.CheckConstraint('borrow_num >= 0 AND borrow_num <= 10', name='check_reader_borrow_num'),
    )
