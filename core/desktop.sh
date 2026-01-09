#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
PROJ="$ROOT/var/lib/debforge/project.db"
FS="$ROOT/runtime/rootfs"
LOG="$ROOT/logs/desktop.log"

kv(){ grep "^$1=" "$PROJ" | cut -d= -f2-; }

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][DESKTOP] %s\n" "$(ts)" "$*" >> "$LOG"; }

main(){
  local name exec icon catg out
  name="$(kv PROJECT_NAME)"
  exec="$(kv PROJECT_EXEC)"
  icon="$(kv PROJECT_ICON)"
  catg="$(kv PROJECT_CATEGORY)"
  out="$FS/usr/share/applications/$name.desktop"

  mkdir -p "$(dirname "$out")"

  printf "%s\n" \
"[Desktop Entry]
Type=Application
Name=$name
Exec=$exec
Icon=$icon
Categories=$catg;
Terminal=false" > "$out"

  log "desktop entry created"
}

main "$@"
