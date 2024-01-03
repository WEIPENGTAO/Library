from exts import db


class Book(db.Model):
    __tablename__ = 'book'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    ISBN = db.Column(db.String(100), db.ForeignKey('booktable.ISBN'), nullable=False, unique=True)
    location = db.Column(db.String(100), nullable=False, default='图书流通室')
    manager_id = db.Column(db.Integer, db.ForeignKey('manager.id'))
    status = db.Column(db.Integer, nullable=False, default=1)
