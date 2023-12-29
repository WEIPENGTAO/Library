from flask import Flask
from flask_migrate import Migrate

import config
from blueprints.manager import manager
from blueprints.reader import reader
from exts import db

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False
app.config.from_object(config)

db.init_app(app)
migrate = Migrate(app, db)

app.register_blueprint(manager)
app.register_blueprint(reader)

if __name__ == '__main__':
    app.run(debug=True)
