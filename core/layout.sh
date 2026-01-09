#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
FS="$ROOT/runtime/rootfs"
LOG="$ROOT/logs/layout.log"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][LAYOUT] %s\n" "$(ts)" "$*" >> "$LOG"; }

dirs(){
  mkdir -p \
    "$FS/DEBIAN" \
    "$FS/usr/bin" \
    "$FS/usr/lib" \
    "$FS/usr/share/doc" \
    "$FS/usr/share/applications" \
    "$FS/usr/share/icons/hicolor" \
    "$FS/etc" \
    "$FS/var/lib" \
    "$FS/var/log"
}

main(){
  rm -rf "$FS"
  dirs
  log "filesystem layout created"
}

main "$@"
