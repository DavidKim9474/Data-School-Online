from flask import *

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello Flask!"

@app.route("/user/<name>")
def user(name):
    return render_template("index.html", name=name)

@app.route("/api/data")
def api_data():
    data = {"alice": 25, "andy": 35}
    return jsonify(data)

app.run()
