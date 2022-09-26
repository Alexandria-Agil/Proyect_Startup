from flask import Flask
from Endpoints.endpoints import endpoints
from Endpoints.auth import auth
from flask_cors import CORS
from Models.database import Database
import os

app = Flask(__name__)
CORS(app)

if __name__ == '__main__':
    DB = Database()
    app.config["DATABASE"] = DB
    app.register_blueprint(endpoints)
    app.register_blueprint(auth)
    API_ADDR=os.environ["API_ADDR"]
    API_PORT=os.environ["API_PORT"]
    try:
        app.run(host=API_ADDR, port=API_PORT)
    except:
        DB.conn.close()