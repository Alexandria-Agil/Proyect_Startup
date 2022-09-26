import os
import jwt

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