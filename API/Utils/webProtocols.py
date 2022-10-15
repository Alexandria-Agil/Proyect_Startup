import os
import jwt
import uuid
from flask import current_app
from PIL import Image

def generate_token(username):

    return jwt.encode(
            {"username": username},
            os.environ["SECRET_KEY"],
            algorithm="HS256")

def decode_token(token):
    return jwt.decode(token, os.environ["SECRET_KEY"], algorithms=["HS256"])

def RequestBody(requestBody, data):
    output = []
    try:
        for item in data:
            if requestBody[item] != None:
                output.append(requestBody[item])
        return output, True
    except:
        return output, False

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in current_app.config['ALLOWED_EXTENSIONS']

def allowed_image(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in current_app.config['ALLOWED_EXTENSIONS_IMG']

def save_file(file):
    filename = f"{str(uuid.uuid4())}.{file.filename.split('.')[-1]}"
    file.save(os.path.join(current_app.config['UPLOAD_FOLDER'], filename))
    return filename

def create_thumbnail(file):
    filename = f"{str(uuid.uuid4())}.{file.filename.split('.')[-1]}"
    path = f"{current_app.config['UPLOAD_FOLDER']}/img"
    imgPath = os.path.join(path, filename)
    file.save(imgPath)

    im = Image.open(imgPath)
    out = im.resize((500, 500))
    out.save(imgPath)
    return filename