#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
LOG="$ROOT/logs/run.log"
STATE="$ROOT/var/lib/debforge/state/run.state"
PIDDIR="$ROOT/var/run/debforge"

timestamp() { date +"%s"; }

log() {
  printf "[%s] %s\n" "$(date)" "$*" >> "$LOG"
}

check_existing_run() {
  for p in "$PIDDIR"/*.pid.data; do
    [ -f "$p" ] || continue
    pid=$(awk -F= '/PID/{print $2}' "$p")
    kill -0 "$pid" 2>/dev/null && return 1
  done
}

prepare_env() {
  export DEBFORGE_RUN=1
  export PATH="$ROOT/bin:$PATH"
}

write_state() {
  printf "RUN_PREPARE\nTIME=%s\n" "$(timestamp)" > "$STATE"
}

log "pre-run started"

check_existing_run || { log "process already running"; exit 1; }

prepare_env
write_state

log "pre-run completed"
