#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
STAGE="$ROOT/runtime/stage"
OUT="$ROOT/output"
LOG="$ROOT/logs/archive.log"
STATE="$ROOT/var/lib/debforge/state/build.state"
LOCK="$ROOT/var/lock/build.lock"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][ARCHIVE] %s\n" "$(ts)" "$*" >> "$LOG"; }

acquire(){ exec 9>"$LOCK"; flock -n 9 || exit 1; }
release(){ flock -u 9 || true; }

size_kb(){
  du -sk "$STAGE" | awk '{print $1}'
}

prepare_control(){
  local ctl="$STAGE/DEBIAN/control"
  sed -i "s/^Installed-Size:.*/Installed-Size: $(size_kb)/" "$ctl"
}

build_deb(){
  mkdir -p "$OUT"
  local name ver arch
  name="$(awk -F': ' '/^Package:/ {print $2}' "$STAGE/DEBIAN/control")"
  ver="$(awk -F': ' '/^Version:/ {print $2}' "$STAGE/DEBIAN/control")"
  arch="$(awk -F': ' '/^Architecture:/ {print $2}' "$STAGE/DEBIAN/control")"
  local deb="$OUT/${name}_${ver}_${arch}.deb"
  dpkg-deb --build "$STAGE" "$deb"
  printf "BUILT=%s\nTIME=%s\n" "$deb" "$(date +%s)" > "$STATE"
}

main(){
  acquire
  log "start"
  prepare_control
  build_deb
  log "done"
  release
}

main "$@"
