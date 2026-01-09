#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
FS="$ROOT/runtime/rootfs"
LOG="$ROOT/logs/permissions.log"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][PERM] %s\n" "$(ts)" "$*" >> "$LOG"; }

fix_dirs(){
  find "$FS" -type d -exec chmod 755 {} +
}

fix_bins(){
  find "$FS/usr/bin" -type f -exec chmod 755 {} + 2>/dev/null || true
}

fix_libs(){
  find "$FS/usr/lib" -type f -exec chmod 644 {} + 2>/dev/null || true
}

fix_docs(){
  find "$FS/usr/share/doc" -type f -exec chmod 644 {} + 2>/dev/null || true
}

main(){
  fix_dirs
  fix_bins
  fix_libs
  fix_docs
  log "permissions normalized"
}

main "$@"
