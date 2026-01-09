#!/usr/bin/env sh
set -e

echo "[ci] package stage"

ls *.tar.xz >/dev/null 2>&1 || echo "[ci] no packages found"
