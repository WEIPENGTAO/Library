from exts import db


class Book(db.Model):
    __tablename__ = 'book'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    book_id = db.Column(db.String(20), unique=True, nullable=False)
    ISBN = db.Column(db.String(100), db.ForeignKey('booktable.ISBN', onupdate='CASCADE', ondelete='CASCADE'),
                     nullable=False)
    location = db.Column(db.String(20), nullable=False, default='图书阅览室')
    manager_id = db.Column(db.Integer, db.ForeignKey('manager.id', onupdate='CASCADE', ondelete='CASCADE'),
                           nullable=False)
    status = db.Column(db.String(10), nullable=False, default='不外借', comment='不外借 未借出 已预约 已借出')

    __table_args__ = (
        db.CheckConstraint('status in ("不外借", "未借出", "已预约", "已借出")', name='check_book_status'),
        db.CheckConstraint('location in ("图书阅览室", "图书流通室")', name='check_book_location'),
        db.CheckConstraint("(location = '图书阅览室' AND status = '不外借') OR (location != '图书阅览室')",
                           name='check_book_location_status')
    )
