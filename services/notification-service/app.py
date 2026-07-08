import logging
from flask import Flask, request, jsonify

logging.basicConfig(level=logging.INFO)

app = Flask(__name__)

@app.route("/notify", methods=["POST"])
def notify():
    data = request.json

    email = data.get("email")
    amount = data.get("amount")

    logging.info(f"Sending payment confirmation to {email}")
    logging.info(f"Payment Amount: ₹{amount}")

    return jsonify({
        "status": "SUCCESS",
        "message": f"Notification sent to {email}"
    })

@app.route("/health")
def health():
    return "OK"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5003)
