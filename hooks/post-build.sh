#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
LOG="$ROOT/logs/build.log"
STATE="$ROOT/var/lib/debforge/state/build.state"
CACHE="$ROOT/var/cache/debforge"
OUTDIR="$ROOT/output"
LOCK="$ROOT/var/lock/build.lock"

timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

log() {
  printf "[%s][POST-BUILD] %s\n" "$(timestamp)" "$*" >> "$LOG"
}

release_lock() {
  rm -f "$LOCK"
}

checksum_artifacts() {
  mkdir -p "$CACHE"
  : > "$CACHE/checksum.cache"
  find "$OUTDIR" -type f -name "*.deb" | while read -r f; do
    sha256sum "$f" >> "$CACHE/checksum.cache"
  done
}

update_state() {
  printf "BUILD_DONE\nTIME=%s\n" "$(date +%s)" > "$STATE"
}

cleanup_temp() {
  rm -rf "$ROOT/runtime/stage"
}

log "post-build started"

checksum_artifacts
cleanup_temp
update_state
release_lock

log "post-build completed"
