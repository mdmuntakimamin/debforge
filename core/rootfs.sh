#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
PROJ="$ROOT/var/lib/debforge/project.db"
FS="$ROOT/runtime/rootfs"
LOG="$ROOT/logs/rootfs.log"

kv(){ grep "^$1=" "$PROJ" | cut -d= -f2-; }

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][ROOTFS] %s\n" "$(ts)" "$*" >> "$LOG"; }

install_bin(){
  local src
  src="$(kv PROJECT_SOURCE_BIN)"
  [ -f "$src" ] || return 0
  cp "$src" "$FS/usr/bin/$(kv PROJECT_NAME)"
}

install_docs(){
  local doc
  doc="$(kv PROJECT_DOC)"
  [ -f "$doc" ] || return 0
  cp "$doc" "$FS/usr/share/doc/$(kv PROJECT_NAME)/README"
}

main(){
  install_bin
  install_docs
  log "rootfs populated"
}

main "$@"
