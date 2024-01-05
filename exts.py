from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
from flask_apscheduler import APScheduler

db = SQLAlchemy()
mail = Mail()
scheduler = APScheduler()