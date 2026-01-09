#!/usr/bin/env sh
set -e

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="$ROOT/benchmarks/results/platform-detect.txt"

. "$(dirname "$0")/utils.sh"

START="$(now_ms)"
. "$ROOT/.platform/detect.sh"
PLATFORM="$(detect_platform)"
END="$(now_ms)"

result "platform" "$PLATFORM"
result "time_ms" "$((END - START))"
