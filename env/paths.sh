#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
CONF="$ROOT/etc/debforge/paths.conf"
STATE="$ROOT/var/lib/debforge/state/paths.state"
LOG="$ROOT/logs/paths.log"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][PATHS] %s\n" "$(ts)" "$*" >> "$LOG"; }

declare -A P

load_conf(){
  while IFS='=' read -r k v; do
    [[ "$k" =~ ^\#|^\[|^$ ]] && continue
    P["$k"]="$v"
  done < "$CONF"
}

resolve(){
  local key="$1"
  local v="${P[$key]}"
  [ -n "$v" ] || return 1
  printf "%s\n" "$ROOT/${v#/}"
}

export_all(){
  for k in "${!P[@]}"; do
    export "DF_${k^^}=$(resolve "$k")"
  done
}

verify(){
  for d in prefix bindir libdir libexec includedir sharedir confdir; do
    resolve "$d" >/dev/null
  done
}

persist(){
  : > "$STATE"
  for k in "${!P[@]}"; do
    printf "%s=%s\n" "$k" "$(resolve "$k")" >> "$STATE"
  done
}

main(){
  load_conf
  verify
  export_all
  persist
  log "paths resolved"
}

main "$@"
