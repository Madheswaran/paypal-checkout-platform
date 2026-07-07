from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/pay", methods=["POST"])
def pay():

    # Get JWT token from request header
    token = request.headers.get("Authorization")

    # Validate token
    if token != "Bearer jwt-token-demo":
        return jsonify({
            "status": "FAILED",
            "message": "Invalid Token"
        }), 401

    # Read payment details
    data = request.json

    amount = data.get("amount")
    card = data.get("card")

    return jsonify({
        "status": "SUCCESS",
        "message": "Payment Processed Successfully",
        "amount": amount,
        "card": "****" + card[-4:]
    })


@app.route("/health")
def health():
    return "OK"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5002)
