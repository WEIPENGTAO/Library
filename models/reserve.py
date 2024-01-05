from exts import db


class Reserve(db.Model):
    __tablename__ = 'reserve'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    booktable_ISBN = db.Column(db.String(100), db.ForeignKey('booktable.ISBN'))
    reader_id = db.Column(db.Integer, db.ForeignKey('reader.id'))
    reserve_date = db.Column(db.DateTime, comment='预约日期', nullable=False)
    reserve_deadline = db.Column(db.Integer, comment='预约期限（天）', default=3, nullable=False)
    book_id = db.Column(db.Integer, db.ForeignKey('book.id'),nullable=True)
