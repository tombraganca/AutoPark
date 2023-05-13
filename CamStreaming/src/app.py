from flask import Flask, request
import request_access
from dotenv import load_dotenv
import os

app = Flask(__name__)
app.config["DEBUG"] = True
load_dotenv()

print("Loading environment variables")

PORT = int(os.getenv("PORT"))

@app.route("/test", methods=["POST"])
def hello_world():
    data = request.get_json()
    print("Hello World")
    new_request = request_access.Request_access(data['plate'], data['accessType'])
    print(data['plate'], data['accessType'])
    new_request.do_request()
    print("Request sent")
    return {"status": "ok"}


app.run(host='0.0.0.0', port=PORT)
