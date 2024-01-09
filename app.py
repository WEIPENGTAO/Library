from flask import Flask
from flask_cors import CORS
from flask_migrate import Migrate

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

if __name__ == '__main__':
    scheduler.start()
    app.run(debug=True, host='0.0.0.0')
