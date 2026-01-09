#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
LOG="$ROOT/logs/validate.log"
STATE="$ROOT/var/lib/debforge/state/validate.state"
CACHE="$ROOT/var/cache/debforge/control.cache"
OUTDIR="$ROOT/output"

timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

log() {
  printf "[%s][POST-VALIDATE] %s\n" "$(timestamp)" "$*" >> "$LOG"
}

record_controls() {
  : > "$CACHE"
  find "$OUTDIR" -type f -name "*.deb" | while read -r deb; do
    dpkg-deb -I "$deb" >> "$CACHE"
  done
}

finalize_state() {
  printf "VALIDATED\nTIME=%s\n" "$(date +%s)" > "$STATE"
}

log "post-validate started"

record_controls
finalize_state

log "post-validate completed"
