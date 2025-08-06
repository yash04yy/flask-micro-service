from flask import Flask, request, jsonify
from prometheus_client import Counter, generate_latest

app = Flask(__name__)

# Prometheus metrics
REQUEST_COUNT = Counter('app_requests_total', 'Total app HTTP requests', ['method', 'endpoint'])

@app.route("/health", methods=["GET"])
def health():
    REQUEST_COUNT.labels(method="GET", endpoint="/health").inc()
    return jsonify({"status": "UP"}), 200

@app.route("/predict", methods=["POST"])
def predict():
    REQUEST_COUNT.labels(method="POST", endpoint="/predict").inc()
    data = request.get_json()
    response = {
        "input": data,
        "prediction": "class_A"  # dummy response
    }
    return jsonify(response), 200

@app.route("/metrics", methods=["GET"])
def metrics():
    return generate_latest(), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
