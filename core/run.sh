#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
OUT="$ROOT/output"
LOG="$ROOT/logs/run.log"
STATE="$ROOT/var/lib/debforge/state/run.state"
LOCK="$ROOT/var/lock/debforge.lock"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][RUN] %s\n" "$(ts)" "$*" >> "$LOG"; }

latest_deb(){
  ls -t "$OUT"/*.deb 2>/dev/null | head -n1
}

extract_and_run(){
  local deb="$1"
  local tmp="$ROOT/runtime/runfs"
  rm -rf "$tmp"
  mkdir -p "$tmp"
  dpkg-deb -x "$deb" "$tmp"
  local bin
  bin="$(find "$tmp/usr/bin" -type f -perm -111 | head -n1)"
  [ -n "$bin" ] || exit 1
  "$bin" "$@"
}

main(){
  exec 7>"$LOCK"; flock -n 7 || exit 1
  local deb
  deb="$(latest_deb)"
  [ -n "$deb" ] || exit 1
  printf "RUNNING=%s\nTIME=%s\n" "$deb" "$(date +%s)" > "$STATE"
  log "exec $deb"
  shift || true
  extract_and_run "$deb" "$@"
}

main "$@"
