#!/usr/bin/env sh

set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REL="$(cd "$(dirname "$0")" && pwd)"

. "$REL/release.conf"

VERSION="$("$REL/version.sh")"

OUT="$REL/$RELEASE_OUTPUT/$RELEASE_NAME-$VERSION"

mkdir -p "$OUT"

cp "$ROOT"/*.tar.xz "$OUT" 2>/dev/null || true

"$REL/metadata/generate.sh" "$OUT" "$OUT/metadata"
"$REL/integrity.sh" "$OUT"

echo "Release prepared at $OUT"
