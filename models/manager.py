from exts import db


class Manager(db.Model):
    __tablename__ = 'manager'

    work_num = db.Column(db.String(20), primary_key=True)
    name = db.Column(db.String(20), nullable=True, default=None)
    password = db.Column(db.String(20), nullable=False)
    email = db.Column(db.String(45), nullable=True, default=None)

    def __repr__(self):
        return f"<Manager(work_num={self.work_num}, name={self.name}, email={self.email})>"
