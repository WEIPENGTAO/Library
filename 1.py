import os
import oss2
from flask import Flask, request

app = Flask(__name__)

def upload_image_to_cloud(image, bookname):
    allowed_extensions = {'jpg', 'jpeg', 'png'}
    access_key_id = "LTAI5tRcw3czJn4inWxFRchw"
    access_key_secret = "5ip7QkeWFSpNiLp0i0SOi7m0ZHe86K"
    endpoint = "oss-cn-beijing.aliyuncs.com"
    bucket_name = "shudb"
    upload_path = "ks/" + bookname + ".jpg"
    image_url = None

    auth = oss2.Auth(access_key_id, access_key_secret)
    bucket = oss2.Bucket(auth, endpoint, bucket_name)
    bucket.put_object(upload_path, image)
    image_url = f"https://{bucket_name}.{endpoint}/{upload_path}"

    return image_url

@app.route('/upload', methods=['POST'])
def test_upload_image_to_cloud():
    image=request.files['image']
    image_url=upload_image_to_cloud(image,"111")
    return image_url

if __name__ == '__main__':
    app.run(debug=True)