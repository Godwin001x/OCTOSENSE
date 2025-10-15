#!/usr/bin/env bash
set -euo pipefail

# Load frontend env (if present) to get NEXT_PUBLIC_API_URL
if [ -f client/.env.local ]; then
	# shellcheck disable=SC2046
	export $(grep -v '^#' client/.env.local | xargs) || true
fi

BACKEND_URL=${NEXT_PUBLIC_API_URL:-http://127.0.0.1:5000}

echo "Backend ($BACKEND_URL):"
curl -s "$BACKEND_URL/health" || true
echo

echo "Predict ($BACKEND_URL/predict):"
curl -s -X POST -H 'Content-Type: application/json' -d '{"rainfall":85,"humidity":75}' "$BACKEND_URL/predict" || true
echo

echo "Frontend (http://localhost:3000):"
curl -s -o /dev/null -w '%{http_code}\n' http://localhost:3000 || true
