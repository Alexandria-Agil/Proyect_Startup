from flask import current_app, jsonify, request, Blueprint, abort
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
def get_users(username):

    DB = current_app.config["DATABASE"]
    data = DB.GetUsers()
    #houses = webProtocols.FormatHouses(data)

    return jsonify({'status': True, 'users': data}), 200


@endpoints.route('/upload', methods=['POST'])
@token_required
def upload_file(username): #username
    """
    {
        file: FILE,
        title: string,
        description: string,
        thumbnail: IMAGE
    }
    """
    print(request.form)
    print(request.files)
    if request.method == 'POST':
        DB = current_app.config["DATABASE"]
        # check if the post request has the file part
        if 'file' not in request.files:
            return abort(400)

        file = request.files['file'] 
        # If the user does not select a file, the browser submits an
        # empty file without a filename.
        if file.filename == '':
            return abort(400)

        if file and webProtocols.allowed_file(file.filename):
            title = request.form["title"]
            description = request.form["description"]
            
            thumb = request.files['thumbnail']
            thumbpath = "None.jpg"
            if not thumb.filename == '':
                if not webProtocols.allowed_image(thumb.filename):
                    return abort(405)
                thumbpath = webProtocols.create_thumbnail(thumb)

            filename = webProtocols.save_file(file)
 
            #status = DB.InsertFile(title, description, file, thumbpath, username)
            status = DB.InsertFile(title, description, filename, thumbpath)

            return jsonify({"status":status}), 200
        else:
            return abort(405)
    else:
        return abort(405)

@endpoints.route('/files', methods=['GET'])
def get_files():

    return jsonify({'status': True}), 200