#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
LOG="$ROOT/logs/container.log"
STATE="$ROOT/var/lib/debforge/state/container.state"
RUNTIME="$ROOT/runtime"
LOCK="$ROOT/var/lock/debforge.lock"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][CONTAINERS] %s\n" "$(ts)" "$*" >> "$LOG"; }

acquire(){ exec 8>"$LOCK"; flock -n 8 || exit 1; }
release(){ flock -u 8 || true; }

detect_backend(){
  if command -v proot >/dev/null 2>&1; then echo proot; return; fi
  if command -v chroot >/dev/null 2>&1 && [ "$(id -u)" -eq 0 ]; then echo chroot; return; fi
  echo none
}

prepare_rootfs(){
  mkdir -p "$RUNTIME/rootfs" "$RUNTIME/stage"
}

enter_container(){
  local backend="$1"; shift
  case "$backend" in
    proot)
      exec proot -R "$RUNTIME/rootfs" -b /proc -b /sys -w / "$@"
      ;;
    chroot)
      exec chroot "$RUNTIME/rootfs" "$@"
      ;;
    none)
      exec "$@"
      ;;
  esac
}

snapshot(){
  tar -C "$RUNTIME/rootfs" -cpf "$RUNTIME/rootfs.snapshot.tar" .
}

restore(){
  [ -f "$RUNTIME/rootfs.snapshot.tar" ] || return
  rm -rf "$RUNTIME/rootfs"
  mkdir -p "$RUNTIME/rootfs"
  tar -C "$RUNTIME/rootfs" -xpf "$RUNTIME/rootfs.snapshot.tar"
}

main(){
  acquire
  prepare_rootfs
  local backend; backend="$(detect_backend)"
  printf "BACKEND=%s\nTIME=%s\n" "$backend" "$(date +%s)" > "$STATE"
  log "backend=$backend"
  shift || true
  [ "$#" -gt 0 ] && enter_container "$backend" "$@"
  release
}

main "$@"
