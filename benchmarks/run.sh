#!/usr/bin/env sh
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"

echo "[benchmarks] running benchmarks"

for b in "$DIR/scripts"/*.sh; do
  [ "$(basename "$b")" = "utils.sh" ] && continue
  sh "$b"
done

echo "[benchmarks] results written to benchmarks/results/"
