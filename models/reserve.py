from exts import db


class Reserve(db.Model):
    __tablename__ = 'reserve'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    booktable_id = db.Column(db.Integer, db.ForeignKey('booktable.id'))
    reader_id = db.Column(db.Integer, db.ForeignKey('reader.id'))
    reserve_date = db.Column(db.DateTime)
    book_id = db.Column(db.Integer, nullable=True)
    status = db.Column(db.Integer, default=0, comment='0:预约未失效 1:预约已失效')
