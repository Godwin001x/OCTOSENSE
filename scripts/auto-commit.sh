#!/usr/bin/env bash
set -euo pipefail

MSG=${1:-"chore: sync workspace changes"}

REPO_ROOT=$(cd "$(dirname "$0")/.." && pwd)
cd "$REPO_ROOT"

# Ensure heavy folders are ignored
echo "Ensuring .gitignore is present..."
if [ ! -f .gitignore ]; then
  cat > .gitignore <<'EOF'
# Node
client/node_modules/
client/.next/
client/out/

# Python
server/venv/
__pycache__/
*.pyc

# Env files
.env
client/.env*
server/.env*

# Logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Misc
.DS_Store
*.swp
EOF
fi

# Untrack any accidentally committed heavy folders
git rm -r --cached client/node_modules 2>/dev/null || true
git rm -r --cached server/venv 2>/dev/null || true

git add -A
if git diff --cached --quiet; then
  echo "No changes to commit."
  exit 0
fi

git commit -m "$MSG"
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
git push -u origin "$CURRENT_BRANCH"
echo "Pushed to origin/$CURRENT_BRANCH"
