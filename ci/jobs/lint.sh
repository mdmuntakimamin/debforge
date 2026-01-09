#!/usr/bin/env sh
set -e

echo "[ci] lint stage"

if command -v shellcheck >/dev/null 2>&1; then
  find . -type f -name "*.sh" -exec shellcheck {} \;
else
  echo "[ci] shellcheck not installed, skipping"
fi
