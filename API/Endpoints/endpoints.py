from flask import current_app, jsonify, request, Blueprint
import Utils.protocols as protocols
import Utils.webProtocols as webProtocols
from functools import wraps

endpoints = Blueprint('endpoints', __name__)

def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = None
        if "Authorization" in request.headers:
            token = request.headers["Authorization"]
        if not token:
            return {
                "message": "Authentication Token is missing!",
                "data": None,
                "error": "Unauthorized"
            }, 401
        try:
            DB = current_app.config["DATABASE"]
            data = webProtocols.decode_token(token)
            username = data["username"]
            found_user = DB.UserExists(username)
            if not found_user:
                return {
                "message": "Invalid Authentication token!",
                "data": None,
                "error": "Unauthorized"
            }, 401
        except Exception as e:
            return {
                "message": "Something went wrong",
                "data": None,
                "error": str(e)
            }, 500

        return f(username, *args, **kwargs)

    return decorated

@endpoints.route('/users', methods=['GET'])
@token_required
def get_houses(username):

    DB = current_app.config["DATABASE"]
    data = DB.GetUsers()
    #houses = webProtocols.FormatHouses(data)

    return jsonify({'status': True, 'users': data}), 200

