from flask import Flask
import request_access
from dotenv import load_dotenv
import os

app = Flask(__name__)
app.config["DEBUG"] = True
load_dotenv()

print("Loading environment variables")

PORT = int(os.getenv("PORT"))

@app.route("/test", methods=["GET"])
def hello_world():
    print("Hello World")
    new_request = request_access.Request_access('ABC1234', 'in')
    new_request.do_request()
    print("Request sent")
    return {"status": "ok"}


app.run(host='0.0.0.0', port=PORT)
