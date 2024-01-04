from flask import Flask
from flask_migrate import Migrate
from flask_cors import CORS

import config
from blueprints.manager import manager
from blueprints.reader import reader
from exts import db, mail

app = Flask(__name__)
CORS(app)
app.config['JSON_AS_ASCII'] = False
app.config.from_object(config)

db.init_app(app)
migrate = Migrate(app, db)
mail.init_app(app)

app.register_blueprint(manager)
app.register_blueprint(reader)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
