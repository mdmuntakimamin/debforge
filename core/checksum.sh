#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
FS="$ROOT/runtime/rootfs"
OUT="$FS/DEBIAN/md5sums"
CACHE="$ROOT/var/cache/debforge/checksum.cache"
LOG="$ROOT/logs/checksum.log"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][CHECKSUM] %s\n" "$(ts)" "$*" >> "$LOG"; }

main(){
  : > "$OUT"
  find "$FS" -type f ! -path "$FS/DEBIAN/*" -print0 |
  while IFS= read -r -d '' f; do
    md5sum "$f" | sed "s|$FS/||" >> "$OUT"
  done
  sha256sum "$OUT" > "$CACHE"
  log "checksums generated"
}

main "$@"
