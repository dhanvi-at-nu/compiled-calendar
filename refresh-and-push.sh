#!/usr/bin/env bash
# refresh-and-push.sh — regenerate the public site/ output and push to github.
# Run from the project dir (C:\Hermes Workspace\cal\).

set -euo pipefail
cd "$(dirname "$0")"

VENV_PY=".venv/Scripts/python.exe"

echo "[1/3] regenerating site/ ..."
"$VENV_PY" publish.py

echo
echo "[2/3] staging site/ ..."
git add site/

# Skip commit if there are no changes
if git diff --cached --quiet; then
  echo "no changes to commit."
  exit 0
fi

echo "[3/3] committing and pushing ..."
git -c user.name="Dhanvi" -c user.email="dhanvi@users.noreply.github.com" \
    commit -m "refresh compiled calendar $(date -u +%Y-%m-%dT%H:%M:%SZ)"
git push

echo
echo "done. github pages will update in a few seconds:"
echo "  https://dhanvi-at-nu.github.io/compiled-calendar/"
