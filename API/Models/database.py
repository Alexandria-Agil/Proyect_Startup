import psycopg2
from passlib.apps import custom_app_context as pwd_context
import os

class Database:

    def __init__(self):
        self.conn = self.Connect()
        self.conn.autocommit = True

    def LogIn(self, username, password):
        cur = self.conn.cursor()
        cur.execute(f"SELECT user_password FROM alexandria.users WHERE user_username = '{username}';")
        usr = cur.fetchone()
        cur.close()
        try:
            password_hash = usr[0]
        except:
            return False

        if not usr or not self.verify_password(password, password_hash):
            return False

        return True
    
    def Connect(self):
        DATABASE = os.environ["DATABASE"]
        USER = os.environ["USER_DB"]
        PASSWORD = os.environ["PASSWORD_DB"]
        PORT = os.environ["PORT_DB"]
        HOST = os.environ["HOST_DB"]
        return psycopg2.connect(database=DATABASE, user=USER, host=HOST, port=PORT, password=PASSWORD) 

    def UserExists(self, username):
        try:
            cur = self.conn.cursor()
            cur.execute(f"SELECT id FROM alexandria.users WHERE user_username = '{username}';")
            found_user = cur.fetchone()
            cur.close()
            if found_user:
                return True
        except:
            return False

    def Register(self, username, password, email="test@test.com"):
        cur = self.conn.cursor()
        pswd_hash = self.hash_password(password)
        SQLTotal = ""
        SQLTotal += f"""INSERT INTO alexandria.users(user_username, user_password, email, created_on) 
                    VALUES('{username}','{pswd_hash}', '{email}', current_timestamp);"""
        cur.execute(SQLTotal)
        cur.close()
        return True


    def GetUsers(self):
        cur = self.conn.cursor()
        SQLQuery = f"""
                    SELECT u.user_username, u.email, u.created_on
                    FROM alexandria.users u;
                    """
        cur.execute(SQLQuery)
        data = cur.fetchall()
        cur.close()
        return data

    def verify_password(self, password, password_hash):
        return pwd_context.verify(password, password_hash)

    def hash_password(self, password):
        return pwd_context.encrypt(password)