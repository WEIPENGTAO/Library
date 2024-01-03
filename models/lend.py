from exts import db


class Lend(db.Model):
    __tablename__ = 'lend'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    book_id = db.Column(db.Integer, db.ForeignKey('book.id'))
    read_id = db.Column(db.Integer, db.ForeignKey('reader.id'))
    lend_date = db.Column(db.DateTime)
    return_date = db.Column(db.DateTime, comment='实际还书日期')
    due_date = db.Column(db.DateTime, comment='应还日期')
    status = db.Column(db.Integer, default=0, comment='0:未还 1:已还 2:超期未还')
