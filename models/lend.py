from exts import db


class Lend(db.Model):
    __tablename__ = 'lend'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    book_id = db.Column(db.String(20), db.ForeignKey('book.book_id', onupdate='CASCADE', ondelete='CASCADE'))
    reader_id = db.Column(db.Integer, db.ForeignKey('reader.id', onupdate='CASCADE', ondelete='CASCADE'))
    lend_date = db.Column(db.DateTime)
    return_date = db.Column(db.DateTime, comment='实际还书日期')
    due_date = db.Column(db.DateTime, comment='应还日期')
    status = db.Column(db.String(10), default='未还', comment='已还 未还  超期未还')

    __table_args__ = (
        db.CheckConstraint('status in ("未还", "已还", "超期未还")', name='check_lend_status'),
    )
