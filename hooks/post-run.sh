#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
LOG="$ROOT/logs/run.log"
STATE="$ROOT/var/lib/debforge/state/run.state"
PIDDIR="$ROOT/var/run/debforge"

timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

log() {
  printf "[%s][POST-RUN] %s\n" "$(timestamp)" "$*" >> "$LOG"
}

cleanup_pidfiles() {
  find "$PIDDIR" -type f -name "*.pid*" -delete
}

record_runtime() {
  local duration
  if grep -q "START" "$STATE"; then
    start=$(awk -F= '/START/{print $2}' "$STATE")
    duration=$(( $(date +%s) - start ))
  else
    duration=0
  fi
  printf "RUN_DONE\nEND=%s\nDURATION=%s\n" "$(date +%s)" "$duration" > "$STATE"
}

log "post-run started"

cleanup_pidfiles
record_runtime

log "post-run completed"
