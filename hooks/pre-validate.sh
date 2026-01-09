#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
LOG="$ROOT/logs/validate.log"
STATE="$ROOT/var/lib/debforge/state/validate.state"
OUTDIR="$ROOT/output"

timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

log() {
  printf "[%s][PRE-VALIDATE] %s\n" "$(timestamp)" "$*" >> "$LOG"
}

check_debs() {
  find "$OUTDIR" -type f -name "*.deb" | grep -q .
}

check_control() {
  dpkg-deb -I "$1" >/dev/null 2>&1
}

validate_all() {
  find "$OUTDIR" -type f -name "*.deb" | while read -r d; do
    check_control "$d" || return 1
  done
}

write_state() {
  printf "VALIDATE_PREPARE\nTIME=%s\n" "$(date +%s)" > "$STATE"
}

log "pre-validate started"

check_debs || { log "no deb files"; exit 1; }
validate_all || { log "invalid deb detected"; exit 1; }

write_state
log "pre-validate completed"
