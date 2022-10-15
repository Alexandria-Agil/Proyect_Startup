from datetime import timedelta
import os

class Config:

    MAX_CONTENT_LENGTH  = 1600000000 # change to env
    UPLOAD_FOLDER  = os.environ["UPLOAD_FOLDER"]
    ALLOWED_EXTENSIONS  = {'pdf'}
    ALLOWED_EXTENSIONS_IMG  = {'png','jpg','bmp'}
    PERMANENT_SESSION_LIFETIME = timedelta(minutes=50)
    