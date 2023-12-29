from flask import Flask, request

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False


@app.route('/')
def index():
    return 'Hello World!'


@app.route('/admin/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data['username']
    password = data['password']


if __name__ == '__main__':
    app.run(debug=True)
