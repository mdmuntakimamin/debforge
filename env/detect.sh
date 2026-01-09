#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
LOG="$ROOT/logs/detect.log"
STATE="$ROOT/var/lib/debforge/state/detect.state"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][DETECT] %s\n" "$(ts)" "$*" >> "$LOG"; }

kv(){ printf "%s=%s\n" "$1" "$2" >> "$STATE"; }

cmd(){ command -v "$1" >/dev/null 2>&1; }

arch(){
  uname -m | sed 's/aarch64/arm64/;s/x86_64/amd64/'
}

os(){
  uname -s | tr '[:upper:]' '[:lower:]'
}

tool(){
  cmd "$1" && printf "%s\n" "$1" || printf "missing\n"
}

main(){
  : > "$STATE"
  kv TIME "$(date +%s)"
  kv OS "$(os)"
  kv ARCH "$(arch)"
  kv KERNEL "$(uname -r)"
  kv SHELL "${SHELL:-unknown}"
  kv USER "$(id -un)"
  kv UID "$(id -u)"
  kv GID "$(id -g)"

  kv CC "$(tool gcc)"
  kv CXX "$(tool g++)"
  kv LD "$(tool ld)"
  kv AR "$(tool ar)"
  kv STRIP "$(tool strip)"
  kv PKG_CONFIG "$(tool pkg-config)"
  kv DPKG "$(tool dpkg-deb)"
  kv TAR "$(tool tar)"
  kv MAKE "$(tool make)"
  kv PROOT "$(tool proot)"

  log "detection complete"
}

main "$@"
