#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
CONF="$ROOT/etc/debforge/debforge.conf"
OUT="$ROOT/var/lib/debforge/config.db"
LOG="$ROOT/logs/config.log"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][CONFIG] %s\n" "$(ts)" "$*" >> "$LOG"; }

load(){
  : > "$OUT"
  [ -f "$CONF" ] || return 0
  while IFS='=' read -r k v; do
    [ -z "$k" ] && continue
    printf "%s=%s\n" "$k" "$v" >> "$OUT"
  done < "$CONF"
}

get(){
  grep "^$1=" "$OUT" | cut -d= -f2-
}

resolve(){
  local k v
  for k in BUILD_ROOT CACHE_DIR LOG_DIR; do
    v="$(get "$k" || true)"
    [ -n "$v" ] || continue
    mkdir -p "$v"
  done
}

main(){
  load
  resolve
  log "config loaded"
}

main "$@"
