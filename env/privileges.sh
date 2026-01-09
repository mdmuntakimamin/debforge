#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
LOG="$ROOT/logs/privileges.log"
STATE="$ROOT/var/lib/debforge/state/privileges.state"
LOCK="$ROOT/var/lock/debforge.lock"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][PRIV] %s\n" "$(ts)" "$*" >> "$LOG"; }

is_root(){ [ "$(id -u)" -eq 0 ]; }

can_fakeroot(){
  command -v fakeroot >/dev/null 2>&1
}

enter_root(){
  if is_root; then exec "$@"; fi
  if can_fakeroot; then exec fakeroot "$@"; fi
  exec "$@"
}

drop_env(){
  unset LD_PRELOAD LD_LIBRARY_PATH
}

mark(){
  printf "UID=%s\nGID=%s\nTIME=%s\n" "$(id -u)" "$(id -g)" "$(date +%s)" > "$STATE"
}

main(){
  exec 6>"$LOCK"; flock -n 6 || exit 1
  drop_env
  mark
  log "privilege context prepared"
  shift || true
  [ "$#" -gt 0 ] && enter_root "$@"
}

main "$@"
