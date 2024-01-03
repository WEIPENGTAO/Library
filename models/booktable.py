from exts import db


class BookTable(db.Model):
    __tablename__ = 'booktable'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(100), nullable=False)
    author = db.Column(db.String(100), nullable=False)
    ISBN = db.Column(db.String(100), nullable=False, unique=True)
    price = db.Column(db.Float(10, 2), nullable=False)
    publish = db.Column(db.String(100), nullable=False)
    pub_date = db.Column(db.Date, nullable=False)
    manager_id = db.Column(db.Integer, db.ForeignKey('manager.id'))
    num = db.Column(db.Integer, nullable=False)
    version = db.Column(db.Integer, nullable=False, default=1)
