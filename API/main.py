from flask import Flask
from Endpoints.endpoints import endpoints
from Endpoints.auth import auth
from flask_cors import CORS
from Models.database import Database
from config import Config
import os
from time import sleep

app = Flask(__name__)
CORS(app)

if __name__ == '__main__':
    print("BUILDING API... WAITING FOR DATABASE")
    sleep(30)
    DB = Database()
    app.config.from_object(Config)
    app.config["DATABASE"] = DB
    app.register_blueprint(endpoints)
    app.register_blueprint(auth)
    API_ADDR=os.environ["API_ADDR"]
    API_PORT=os.environ["API_PORT"]
    if not os.path.exists(os.environ['UPLOAD_FOLDER']):
        os.makedirs(os.environ['UPLOAD_FOLDER'])
        os.makedirs(f"{os.environ['UPLOAD_FOLDER']}/img")

    try:
        app.run(host=API_ADDR, port=API_PORT)
    except:
        DB.conn.close()