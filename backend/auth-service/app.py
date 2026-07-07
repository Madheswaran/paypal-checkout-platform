from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/login", methods=["POST"])
def login():

    data = request.json

    username = data.get("username")
    password = data.get("password")

    if username == "admin" and password == "paypal123":
        return jsonify({
            "status": "SUCCESS",
            "token": "jwt-token-demo"
        })

    return jsonify({
        "status": "FAILED"
    }),401


@app.route("/health")
def health():
    return "OK"


if __name__=="__main__":
    app.run(host="0.0.0.0",port=5001)
