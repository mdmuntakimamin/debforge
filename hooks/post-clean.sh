#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
LOG="$ROOT/logs/clean.log"
STATE_DIR="$ROOT/var/lib/debforge/state"
CACHE="$ROOT/var/cache/debforge"
LOCK="$ROOT/var/lock/debforge.lock"

timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

log() {
  printf "[%s][POST-CLEAN] %s\n" "$(timestamp)" "$*" >> "$LOG"
}

reset_states() {
  for s in "$STATE_DIR"/*.state; do
    [ -f "$s" ] || continue
    printf "IDLE\nTIME=%s\n" "$(date +%s)" > "$s"
  done
}

purge_cache() {
  rm -f "$CACHE"/*.cache || true
}

release_lock() {
  rm -f "$LOCK"
}

verify_clean() {
  [ ! -d "$ROOT/runtime/stage" ]
}

log "post-clean started"

purge_cache
reset_states

verify_clean || { log "cleanup verification failed"; exit 1; }

release_lock
log "post-clean completed"
