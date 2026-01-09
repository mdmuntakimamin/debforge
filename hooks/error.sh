#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
LOG="$ROOT/logs/error.log"
STATE="$ROOT/var/lib/debforge/state"
LOCK="$ROOT/var/lock/debforge.lock"

mkdir -p "$(dirname "$LOG")"

timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

log() {
  printf "[%s][ERROR] %s\n" "$(timestamp)" "$*" >> "$LOG"
}

cleanup_locks() {
  rm -f "$ROOT/var/lock/build.lock" "$LOCK"
}

cleanup_pid() {
  rm -f "$ROOT/var/run/debforge/"*.pid*
}

write_state() {
  printf "ERROR\nTIME=%s\nMSG=%s\n" "$(date +%s)" "$1" > "$STATE/build.state"
}

trap 'on_fail $LINENO "$BASH_COMMAND"' ERR

on_fail() {
  local line="$1"
  local cmd="$2"
  log "Failure at line $line"
  log "Command: $cmd"
  cleanup_locks
  cleanup_pid
  write_state "fatal error"
  exit 1
}

log "error hook initialized"
