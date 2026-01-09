#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
LOG="$ROOT/logs/build.log"
STATE="$ROOT/var/lib/debforge/state/build.state"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][BUILD] %s\n" "$(ts)" "$*" >> "$LOG"; }

run(){
  log "run $1"
  "$ROOT/core/$1.sh"
}

main(){
  log "pipeline start"
  printf "START=%s\n" "$(date +%s)" > "$STATE"

  run versioning
  run metadata
  run deps
  run control
  run manpage
  run archive

  printf "END=%s\n" "$(date +%s)" >> "$STATE"
  log "pipeline end"
}

main "$@"
