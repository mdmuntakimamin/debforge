#!/usr/bin/env sh

set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

[ -f "$ROOT/.platform/load.sh" ] && . "$ROOT/.platform/load.sh"
[ -f "$ROOT/plugins/load.sh" ] && . "$ROOT/plugins/load.sh"

export DEBFORGE_ROOT="$ROOT"
