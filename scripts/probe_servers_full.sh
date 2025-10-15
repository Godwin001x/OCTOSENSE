#!/usr/bin/env bash
set -euo pipefail

echo "Backend:"
curl -s http://127.0.0.1:5000/health || true
echo

echo "Predict:"
curl -s -X POST -H 'Content-Type: application/json' -d '{"rainfall":85,"humidity":75}' http://127.0.0.1:5000/predict || true
echo

echo "Frontend:"
curl -s -o /dev/null -w '%{http_code}\n' http://localhost:3000 || true
