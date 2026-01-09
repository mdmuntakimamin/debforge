#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
LOG="$ROOT/logs/sanity.log"
STATE="$ROOT/var/lib/debforge/state/sanity.state"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][SANITY] %s\n" "$(ts)" "$*" >> "$LOG"; }

die(){ log "$1"; exit 1; }

req(){
  for c in "$@"; do
    command -v "$c" >/dev/null 2>&1 || die "missing:$c"
  done
}

dirs(){
  for d in "$@"; do
    [ -d "$d" ] || die "missing_dir:$d"
  done
}

perms(){
  [ -w "$ROOT" ] || die "no_write_root"
}

space(){
  df "$ROOT" | awk 'NR==2 { if ($4 < 10240) exit 1 }' || die "low_disk"
}

no_root_fs(){
  [ "$ROOT" != "/" ] || die "root_fs"
}

main(){
  : > "$STATE"
  no_root_fs
  perms
  dirs "$ROOT/bin" "$ROOT/core" "$ROOT/env" "$ROOT/var"
  req bash awk sed grep tar gzip dpkg-deb
  space
  printf "OK\nTIME=%s\n" "$(date +%s)" > "$STATE"
  log "sanity passed"
}

main "$@"
