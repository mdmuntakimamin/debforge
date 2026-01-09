#!/usr/bin/env sh
set -e

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="$ROOT/benchmarks/results/package-size.txt"

SIZE=0
for f in "$ROOT"/*.tar.xz; do
  [ -f "$f" ] && SIZE=$((SIZE + $(stat -c %s "$f")))
done

echo "total_package_bytes=$SIZE" > "$OUT"
