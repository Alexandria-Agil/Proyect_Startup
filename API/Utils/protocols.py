import re
import jwt

def Retrieve_Data(message):
    output = {}
    message = message.replace('.', '')
    data = message[3:].split(";")
    for items in data:
        items = items.split("=")
        key = items[0]
        value = items[1]
        output[key] = value
    return output
