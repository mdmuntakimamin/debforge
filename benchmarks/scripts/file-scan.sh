#!/usr/bin/env sh
set -e

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="$ROOT/benchmarks/results/file-scan.txt"

. "$(dirname "$0")/utils.sh"

START="$(now_ms)"
COUNT="$(find "$ROOT" -type f | wc -l)"
END="$(now_ms)"

result "files" "$COUNT"
result "time_ms" "$((END - START))"
