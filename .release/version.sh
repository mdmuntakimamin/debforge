#!/usr/bin/env sh

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if [ -f "$ROOT/VERSION" ]; then
  cat "$ROOT/VERSION"
else
  echo "0.0.0"
fi
