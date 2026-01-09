#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
LOG="$ROOT/logs/edit.log"
STATE="$ROOT/var/lib/debforge/state/edit.state"
LOCK="$ROOT/var/lock/debforge.lock"
PROJECT_DB="$ROOT/var/lib/debforge/project.db"
RUNTIME="$ROOT/runtime/extract"

timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

log() {
  printf "[%s][PRE-EDIT] %s\n" "$(timestamp)" "$*" >> "$LOG"
}

acquire_lock() {
  exec 9>"$LOCK"
  flock -n 9 || exit 1
}

verify_project() {
  [ -f "$PROJECT_DB" ]
}

prepare_runtime() {
  mkdir -p "$RUNTIME"
}

mark_state() {
  printf "EDITING\nSTART=%s\n" "$(date +%s)" > "$STATE"
}

log "pre-edit started"

acquire_lock
verify_project || { log "project database missing"; exit 1; }
prepare_runtime
mark_state

log "pre-edit completed"
