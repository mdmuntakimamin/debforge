#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
LOG="$ROOT/logs/clean.log"
LOCK="$ROOT/var/lock/debforge.lock"
STATE="$ROOT/var/lib/debforge/state"

timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

log() {
  printf "[%s][PRE-CLEAN] %s\n" "$(timestamp)" "$*" >> "$LOG"
}

ensure_idle() {
  for f in "$STATE"/*.state; do
    [ -f "$f" ] || continue
    grep -q "RUN" "$f" && return 1
  done
}

acquire_lock() {
  exec 8>"$LOCK" || exit 1
  flock -n 8 || exit 1
}

log "pre-clean started"

acquire_lock

if ! ensure_idle; then
  log "system not idle; abort clean"
  exit 1
fi

log "pre-clean completed"
