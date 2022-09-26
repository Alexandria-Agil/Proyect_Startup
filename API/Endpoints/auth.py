from flask import current_app, jsonify, request, Blueprint
import Utils.webProtocols as webProtocols

auth = Blueprint('auth', __name__)

@auth.route('/login', methods=['POST'])
def login():
    body, status = webProtocols.RequestBody(request.json, ["username", "password"])
    if not status:
        return jsonify({'status': False}), 400 #BAD REQUEST null values or werent passed
    name = body[0]
    pswd = body[1]
    DB = current_app.config["DATABASE"]

    if DB.LogIn(name, pswd): 
        token = webProtocols.generate_token(name)
        return jsonify({'status': True, 'token': token, "username":name}), 200 #OK
    else:
        return jsonify({'status': False}), 404 # Not Found


@auth.route('/register', methods=['POST'])
def register():
    body, status = webProtocols.RequestBody(request.json, ["username", "password", "email"])
    if not status:
        return jsonify({'status': False}), 400 #BAD REQUEST null values or werent passed
    name = body[0]
    pswd = body[1]
    email = body[2]
    DB = current_app.config["DATABASE"]

    if  DB.UserExists(name):
        return jsonify({'status': False}), 409 # Duplicate exists
    else:
        status = DB.Register(name, pswd, email)
        return jsonify({'status': status}), 201 # User created