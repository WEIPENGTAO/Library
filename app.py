from flask import Flask
from flask_cors import CORS
from flask_migrate import Migrate
import oss2
import config
from blueprints import *
from exts import db, mail, scheduler

app = Flask(__name__)
CORS(app)
app.config.from_object(config)

db.init_app(app)
migrate = Migrate(app, db)
mail.init_app(app)
scheduler.init_app(app)

app.register_blueprint(manager)
app.register_blueprint(reader)

@app.route('/')
def upload_image_to_cloud(image_file, bookname="1"):
    access_key_id = "LTAI5tRcw3czJn4inWxFRchw"
    access_key_secret = "5ip7QkeWFSpNiLp0i0SOi7m0ZHe86K"
    endpoint = "oss-cn-beijing.aliyuncs.com"
    bucket_name = "shudb"
    upload_path = "ks/" + bookname + ".jpg"

    # 获取图片内容
    image_content = image_file.read()

    # 初始化 OSS 客户端
    auth = oss2.Auth(access_key_id, access_key_secret)
    bucket = oss2.Bucket(auth, endpoint, bucket_name)

    # 将图片内容上传到 OSS
    bucket.put_object(upload_path, image_content)

    # 获取上传后的图片 URL
    image_url = f"https://{bucket_name}.{endpoint}/{upload_path}"

    return image_url


if __name__ == '__main__':
    scheduler.start()
    app.run(debug=True, host='0.0.0.0')

