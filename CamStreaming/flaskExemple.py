# Description: Exemple de code pour utiliser Flask
from flask import Flask
from flask import render_template

#get template from ./templates/index.html

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')
