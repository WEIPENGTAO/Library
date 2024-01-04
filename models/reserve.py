from exts import db


class Reserve(db.Model):
    __tablename__ = 'reserve'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    booktable_ISBN = db.Column(db.String(100), db.ForeignKey('booktable.ISBN'))
    reader_id = db.Column(db.Integer, db.ForeignKey('reader.id'))
    reserve_date = db.Column(db.DateTime)
    reserve_deadline = db.Column(db.Integer, comment='预约期限（天）', default=3)
    book_id = db.Column(db.Integer, nullable=True)
    status = db.Column(db.String(10), default='预约未失效', comment='预约未失效 预约已失效')

    __table_args__ = (
        db.CheckConstraint('status in ("预约未失效", "预约已失效")', name='check_reserve_status'),
    )
