from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


class Reader(db.Model):
    __tablename__ = 'reader'

    reader_id = db.Column(db.String(20), primary_key=True)
    name = db.Column(db.String(20), nullable=True, default=None)
    password = db.Column(db.String(20), nullable=False, default='123456')
    email = db.Column(db.String(45), nullable=True, default=None)
    phone = db.Column(db.String(20), nullable=True, default=None)
    sex = db.Column(db.String(1), nullable=True, default=None)
    fine = db.Column(db.DECIMAL(6, 2), nullable=False, default=0.0)
    borrow_num = db.Column(db.Integer, nullable=False, default=0,
                           comment='一名读者最多只能借阅十本图书，且每本图书最多只能借两个月')

    def __repr__(self):
        return f"<Reader(reader_id={self.reader_id}, name={self.name}, email={self.email}, phone={self.phone}, sex={self.sex}, fine={self.fine}, borrow_num={self.borrow_num})>"
