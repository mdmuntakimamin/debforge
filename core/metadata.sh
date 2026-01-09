#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
PROJ="$ROOT/var/lib/debforge/project.db"
FMT="$ROOT/formats/project.map"
LOG="$ROOT/logs/metadata.log"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][META] %s\n" "$(ts)" "$*" >> "$LOG"; }

normalize(){
  local k v
  while IFS='=' read -r k v; do
    [ -z "$k" ] && continue
    printf "%s=%s\n" "$k" "$(echo "$v" | tr -s ' ')"
  done < "$PROJ"
}

validate(){
  grep -E '^PROJECT_NAME=' "$PROJ" >/dev/null
  grep -E '^PROJECT_VERSION=' "$PROJ" >/dev/null
}

export_map(){
  local out="$ROOT/runtime/metadata.map"
  : > "$out"
  while IFS='=' read -r k v; do
    grep -q "^$k:" "$FMT" && printf "%s:%s\n" "$k" "$v" >> "$out"
  done < "$PROJ"
}

main(){
  log "start"
  validate
  normalize > "$PROJ.tmp"
  mv "$PROJ.tmp" "$PROJ"
  export_map
  log "done"
}

main "$@"
