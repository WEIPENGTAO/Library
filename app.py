from flask import Flask

import config
from blueprints.manager import manager
from exts import db
from flask_migrate import Migrate

from models.manager import Manager

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False
app.config.from_object(config)

db.init_app(app)
migrate = Migrate(app, db)

app.register_blueprint(manager)

if __name__ == '__main__':
    app.run(debug=True)
