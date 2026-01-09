#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
FS="$ROOT/runtime/rootfs"
LOG="$ROOT/logs/validate.log"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][VALIDATE] %s\n" "$(ts)" "$*" >> "$LOG"; }

fail(){ log "$1"; exit 1; }

check_control(){
  [ -f "$FS/DEBIAN/control" ] || fail "missing control"
}

check_exec(){
  find "$FS/usr/bin" -type f -perm -0100 | grep -q . || fail "no executables"
}

check_perms(){
  find "$FS/DEBIAN" -type f ! -perm 755 | grep -q . && fail "bad script perms"
}

main(){
  check_control
  check_exec
  check_perms
  log "validation passed"
}

main "$@"
