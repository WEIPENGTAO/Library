import time
from datetime import timedelta

from flask_mail import Message

from exts import db, mail, scheduler
from models.book import Book
from models.booktable import BookTable
from models.lend import Lend
from models.reserve import Reserve


# 还书提醒
@scheduler.task('cron', id='do_task_1', day='*', hour='0', minute='0', second='0')
def task1():
    lends = Lend.query.filter(Lend.due_date < time.strftime('%Y-%m-%d %H:%M:%S', time.localtime()),
                              Lend.status == '未归还').all()
    for lend in lends:
        reader = lend.reader
        book = lend.book
        message = Message(subject='图书管理系统通知', recipients=[reader.email],
                          body='您借阅的图书《' + book.booktable.name + '》已到期，请及时归还')
        mail.send(message)


# 预约到书提醒
@scheduler.task('cron', id='do_task_2', day='*', hour='0', minute='0', second='0')
def task2():
    reserves = Reserve.query.filter().all()
    for reserve in reserves:
        reader = reserve.reader
        booktable = reserve.booktable
        message = Message(subject='图书管理系统通知', recipients=[reader.email],
                          body='您预约的图书《' + booktable.name + '》已到，请及时借阅')
        mail.send(message)


# 删除过期预约
@scheduler.task('cron', id='do_task_3', day='*', hour='0', minute='0', second='0')
def task3():
    reserves = Reserve.query.filter(
        time.strftime('%Y-%m-%d %H:%M:%S', time.localtime()) - Reserve.reserve_date > Reserve.reserve_deadline).all()
    for reserve in reserves:
        db.session.delete(reserve)
    db.session.commit()


# 更新图书数量
@scheduler.task('cron', id='do_task_4', day='*', hour='0', minute='0', second='0')
def task4():
    booktables = BookTable.query.all()
    ISBN_list = []
    for booktable in booktables:
        ISBN_list.append(booktable.ISBN)
    # 更新图书数量
    for ISBN in ISBN_list:
        booktable = BookTable.query.filter(BookTable.ISBN == ISBN).first()
        booktable.num = Book.query.filter(Book.ISBN == ISBN).count()
    db.session.commit()


# 提前5天提醒读者还书
@scheduler.task('cron', id='do_task_5', day='*', hour='0', minute='0', second='0')
def task5():
    lends = Lend.query.filter(Lend.due_date - timedelta(days=5) < time.strftime('%Y-%m-%d %H:%M:%S', time.localtime()),
                              Lend.status == '未归还').all()
    for lend in lends:
        reader = lend.reader
        book = lend.book
        message = Message(subject='图书管理系统通知', recipients=[reader.email],
                          body='您借阅的图书《' + book.booktable.name + '》还有5天到期，请及时归还')
        mail.send(message)
