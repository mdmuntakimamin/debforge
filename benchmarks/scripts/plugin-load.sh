#!/usr/bin/env sh
set -e

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="$ROOT/benchmarks/results/plugin-load.txt"

. "$(dirname "$0")/utils.sh"

START="$(now_ms)"
[ -f "$ROOT/plugins/load.sh" ] && . "$ROOT/plugins/load.sh" && load_plugins || true
END="$(now_ms)"

result "plugin_load_time_ms" "$((END - START))"
