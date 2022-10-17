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
def get_houses(username):

    DB = current_app.config["DATABASE"]
    data = DB.GetUsers()
    #houses = webProtocols.FormatHouses(data)

    return jsonify({'status': True, 'users': data}), 200


#@token_required
@endpoints.route('/upload', methods=['POST'])
def upload_file():
    """
    {
        file: FILE,
        title: string,
        description: string,
        thumbnail: IMAGE
    }
    """
    if request.method == 'POST':
        # check if the post request has the file part
        print(request.files)
        print(request.form)
        if 'file' not in request.files:
            return abort(408)

        file = request.files['file'] 
        # If the user does not select a file, the browser submits an
        # empty file without a filename.
        if file.filename == '':
            return abort(407)

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
            print("file: ",file)
            print()
            print("filename: ",filename)
            print()
            print("thumb: ",thumb)
            print()
            print("thumbpath: ",thumbpath)
            print()
            #video = Videos(title=title, description=description, video=filename, thumbnail = thumbpath, user_id = current_user.id)
            #db.session.add(video)
            #db.session.commit()

            return jsonify({"status":200})
        else:
            return abort(405)
    else:
        return abort(405)