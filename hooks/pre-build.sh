#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
LOG="$ROOT/logs/build.log"
STATE="$ROOT/var/lib/debforge/state/build.state"
LOCK="$ROOT/var/lock/build.lock"
CACHE="$ROOT/var/cache/debforge"

timestamp() { date +"%s"; }

log() {
  printf "[%s] %s\n" "$(date)" "$*" >> "$LOG"
}

lock() {
  exec 9>"$LOCK" || exit 1
  flock -n 9 || exit 1
}

check_tools() {
  for t in dpkg-deb tar gzip; do
    command -v "$t" >/dev/null || return 1
  done
}

check_space() {
  df "$ROOT" | awk 'NR==2 { if ($4 < 102400) exit 1 }'
}

prepare_cache() {
  mkdir -p "$CACHE"
  : > "$CACHE/build.cache"
}

write_state() {
  printf "BUILD_PREPARE\nTIME=%s\n" "$(timestamp)" > "$STATE"
}

log "pre-build started"

lock
check_tools || { log "missing tools"; exit 1; }
check_space || { log "low disk space"; exit 1; }

prepare_cache
write_state

log "pre-build completed"
