#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
PROJ="$ROOT/var/lib/debforge/project.db"
FS="$ROOT/runtime/rootfs"
LOG="$ROOT/logs/icons.log"

kv(){ grep "^$1=" "$PROJ" | cut -d= -f2-; }

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][ICON] %s\n" "$(ts)" "$*" >> "$LOG"; }

install_icon(){
  local src="$1" size="$2"
  local dir="$FS/usr/share/icons/hicolor/${size}x${size}/apps"
  mkdir -p "$dir"
  cp "$src" "$dir/$(kv PROJECT_NAME).png"
}

main(){
  local icon
  icon="$(kv PROJECT_ICON_FILE)"
  [ -f "$icon" ] || exit 0
  for s in 16 24 32 48 64 128 256; do
    install_icon "$icon" "$s"
  done
  log "icons installed"
}

main "$@"
