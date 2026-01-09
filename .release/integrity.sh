#!/usr/bin/env sh

set -e

OUT="$1"

[ -d "$OUT" ] || exit 1

for f in "$OUT"/*; do
  [ -f "$f" ] && sha256sum "$f" > "$f.sha256"
done
