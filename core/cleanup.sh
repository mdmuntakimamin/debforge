#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
RT="$ROOT/runtime"
CACHE="$ROOT/var/cache/debforge"
LOG="$ROOT/logs/cleanup.log"
LOCK="$ROOT/var/lock/build.lock"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][CLEAN] %s\n" "$(ts)" "$*" >> "$LOG"; }

safe_rm(){
  [ -e "$1" ] && rm -rf "$1"
}

main(){
  exec 8>"$LOCK"; flock -n 8 || exit 0
  safe_rm "$RT/stage"
  safe_rm "$RT/extract"
  find "$CACHE" -type f -mtime +3 -delete || true
  find "$ROOT/logs" -type f -size +10M -delete || true
  log "cleanup complete"
}

main "$@"
