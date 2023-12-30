# 数据库的配置信息
HOST = '127.0.0.1'
PORT = 3306
DATABASE = 'library1'
USERNAME = 'root'
PASSWORD = '123456'
DB_URI = 'mysql+pymysql://%s:%s@%s:%s/%s?charset=utf8' % (USERNAME, PASSWORD, HOST, PORT, DATABASE)
SQLALCHEMY_DATABASE_URI = DB_URI

# 邮箱配置信息
MAIL_SERVER = 'smtp.qq.com'
MAIL_PORT = 465
MAIL_USE_SSL = True
MAIL_USERNAME = ''
MAIL_PASSWORD = ''
MAIL_DEFAULT_SENDER = ''
