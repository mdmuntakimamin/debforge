#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
PROJECT="$PWD"
LOG="$ROOT/logs/edit.log"
STATE="$ROOT/var/lib/debforge/state/edit.state"

timestamp() { date +"%s"; }

log() {
  printf "[%s] %s\n" "$(date)" "$*" >> "$LOG"
}

validate_project() {
  test -f "$PROJECT/df.project" || return 1
  grep -q "^name=" "$PROJECT/df.project"
  grep -q "^version=" "$PROJECT/df.project"
}

normalize_files() {
  find "$PROJECT" -type f -exec sed -i 's/\r$//' {} +
}

write_state() {
  printf "EDIT_OK\nTIME=%s\nPATH=%s\n" "$(timestamp)" "$PROJECT" > "$STATE"
}

log "post-edit started"

normalize_files

if ! validate_project; then
  log "project validation failed"
  exit 1
fi

write_state
log "post-edit completed"
