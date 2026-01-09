#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
DB="$ROOT/var/lib/debforge/project.db"
LOG="$ROOT/logs/project.log"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][PROJECT] %s\n" "$(ts)" "$*" >> "$LOG"; }

init(){
  : > "$DB"
  printf "%s\n" \
"PROJECT_NAME=app" \
"PROJECT_VERSION=1.0.0" \
"PROJECT_ARCH=all" \
"PROJECT_MAINTAINER=unknown" \
"PROJECT_DESC=package" \
"PROJECT_EXEC=/usr/bin/app" \
"PROJECT_ICON_FILE=" \
"PROJECT_CATEGORY=Utility" >> "$DB"
  log "project initialized"
}

get(){
  grep "^$1=" "$DB" | cut -d= -f2-
}

set(){
  local k="$1" v="$2"
  sed -i "/^$k=/d" "$DB"
  printf "%s=%s\n" "$k" "$v" >> "$DB"
  log "set $k"
}

validate(){
  for k in PROJECT_NAME PROJECT_VERSION PROJECT_ARCH PROJECT_EXEC; do
    get "$k" >/dev/null || exit 1
  done
  log "project valid"
}

case "${1:-}" in
  init) init ;;
  get) get "$2" ;;
  set) set "$2" "$3" ;;
  validate) validate ;;
esac
