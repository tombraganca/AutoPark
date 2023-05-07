from flask import Flask
import request_access

app = Flask(__name__)
app.config["DEBUG"] = True


@app.route("/test", methods=["GET"])
def hello_world():
    # return json {"status": "ok"}
    new_request = request_access.Request_access('ABC1234', 'in')
    new_request.do_request()
    return {"status": "ok"}


app.run(port=8000)
