#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
SEC="$ROOT/etc/debforge/security.conf"
LOG="$ROOT/logs/sandbox.log"
STATE="$ROOT/var/lib/debforge/state/sandbox.state"
LOCK="$ROOT/var/lock/debforge.lock"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][SANDBOX] %s\n" "$(ts)" "$*" >> "$LOG"; }

read_policy(){
  while IFS='=' read -r k v; do
    [[ "$k" =~ ^\#|^\[|^$ ]] && continue
    export "POL_${k^^}=$v"
  done < "$SEC"
}

apply_limits(){
  ulimit -t "${POL_CPU_TIME:-0}" || true
  ulimit -v "${POL_MEMORY_MB:-0}" || true
  ulimit -f "${POL_FILE_SIZE:-0}" || true
  ulimit -u "${POL_PROCESSES:-0}" || true
}

fs_guard(){
  IFS=',' read -ra deny <<< "${POL_DENY_WRITE:-}"
  for p in "${deny[@]}"; do
    [ -n "$p" ] && chmod -R a-w "$ROOT/$p" 2>/dev/null || true
  done
}

net_guard(){
  [ "${POL_NETWORK:-false}" = "false" ] && export http_proxy= https_proxy= ftp_proxy=
}

enter(){
  apply_limits
  fs_guard
  net_guard
  exec "$@"
}

main(){
  exec 7>"$LOCK"; flock -n 7 || exit 1
  read_policy
  printf "ACTIVE\nTIME=%s\n" "$(date +%s)" > "$STATE"
  log "sandbox active"
  shift || true
  [ "$#" -gt 0 ] && enter "$@"
}

main "$@"
