#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
FS="$ROOT/runtime/rootfs"
LOG="$ROOT/logs/strip.log"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][STRIP] %s\n" "$(ts)" "$*" >> "$LOG"; }

strip_file(){
  local f="$1"
  file "$f" | grep -q ELF || return 0
  strip --strip-unneeded "$f" 2>/dev/null || true
}

main(){
  command -v strip >/dev/null 2>&1 || exit 0
  find "$FS" -type f -perm -0100 -print0 |
  while IFS= read -r -d '' f; do
    strip_file "$f"
  done
  log "strip completed"
}

main "$@"
