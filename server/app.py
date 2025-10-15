from flask import Flask, jsonify, request
from flask_cors import CORS
from model.ai_model import predict_risk
import os

app = Flask(__name__)
# Restrict CORS to specific origin (env FRONTEND_ORIGIN) or allow localhost:3000 by default
frontend_origin = os.getenv("FRONTEND_ORIGIN", "http://localhost:3000")
CORS(app, resources={r"/*": {"origins": [frontend_origin]}})

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json() or {}
    rainfall = data.get('rainfall', 0)
    humidity = data.get('humidity', 60)
    risk = predict_risk(rainfall, humidity)
    return jsonify({'risk': risk})

@app.route('/health', methods=['GET'])
def health():
    return jsonify({'status': 'ok'})

if __name__ == '__main__':
    port = int(os.getenv("PORT", "5000"))
    app.run(port=port, debug=True)
