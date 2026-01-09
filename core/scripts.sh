#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
PROJ="$ROOT/var/lib/debforge/project.db"
OUT="$ROOT/runtime/rootfs/DEBIAN"
LOG="$ROOT/logs/scripts.log"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][SCRIPTS] %s\n" "$(ts)" "$*" >> "$LOG"; }

kv(){ grep "^$1=" "$PROJ" | cut -d= -f2-; }

write(){
  local f="$1"
  shift
  printf "%s\n" "$@" > "$OUT/$f"
  chmod 755 "$OUT/$f"
}

preinst(){
  write preinst \
"#!/bin/sh
set -e
if [ \"\$1\" = \"install\" ]; then
  true
fi
exit 0"
}

postinst(){
  write postinst \
"#!/bin/sh
set -e
if [ \"\$1\" = \"configure\" ]; then
  ldconfig || true
  update-desktop-database >/dev/null 2>&1 || true
fi
exit 0"
}

prerm(){
  write prerm \
"#!/bin/sh
set -e
if [ \"\$1\" = \"remove\" ]; then
  true
fi
exit 0"
}

postrm(){
  write postrm \
"#!/bin/sh
set -e
if [ \"\$1\" = \"purge\" ]; then
  rm -rf /var/lib/$(kv PROJECT_NAME) || true
fi
exit 0"
}

main(){
  mkdir -p "$OUT"
  preinst
  postinst
  prerm
  postrm
  log "scripts written"
}

main "$@"
