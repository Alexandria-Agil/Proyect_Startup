import os
import jwt
from base64 import encodebytes, b64encode
import io
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

def get_response_image(filename):
    path = f"{current_app.config['UPLOAD_FOLDER']}/img"
    image_path = os.path.join(path, filename)
    pil_img = Image.open(image_path, mode='r') # reads the PIL image
    byte_arr = io.BytesIO()
    pil_img.save(byte_arr, format='PNG') # convert the PIL image to byte array
    encoded_img = encodebytes(byte_arr.getvalue()).decode('ascii') # encode as base64
    return encoded_img

def get_response_pdf(filename):
    path = f"{current_app.config['UPLOAD_FOLDER']}"
    image_path = os.path.join(path, filename)

    #with open(f"{image_path}", "rb") as pdf_file:
    #    encoded_string = b64encode(pdf_file.read())
    #return encoded_string
    return image_path