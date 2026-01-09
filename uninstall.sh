#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
PREFIX="$PREFIX"
TARGET="$PREFIX/bin"

die(){ echo "[UNINSTALL][FATAL] $1"; exit 1; }

remove_bins(){
  for f in "$TARGET"/debforge*; do
    [ -L "$f" ] && rm -f "$f"
  done
}

stop_running(){
  local pidfile="$ROOT/var/run/debforge/debforge.pid"
  [ -f "$pidfile" ] || return
  kill "$(cat "$pidfile")" 2>/dev/null || true
  rm -f "$pidfile"
}

wipe_tree(){
  rm -rf "$ROOT"
}

main(){
  stop_running
  remove_bins
  wipe_tree
  echo "[UNINSTALL] DebForge removed completely"
}

main
