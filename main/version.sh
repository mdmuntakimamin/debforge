#!/usr/bin/env sh

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

[ -f "$ROOT/VERSION" ] && cat "$ROOT/VERSION" || echo "0.0.0"
