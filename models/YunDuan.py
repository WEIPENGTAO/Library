# -*- coding: utf-8 -*-
import oss2
def upload_image_to_oss(image_file,bookname):
    access_key_id = "LTAI5tRcw3czJn4inWxFRchw"
    access_key_secret = "5ip7QkeWFSpNiLp0i0SOi7m0ZHe86K"
    endpoint = "oss-cn-beijing.aliyuncs.com"
    bucket_name = "shudb"
    upload_path = "uploadimg/"+bookname+".jpg"

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

