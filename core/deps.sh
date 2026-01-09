#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
PROJ="$ROOT/var/lib/debforge/project.db"
LOG="$ROOT/logs/deps.log"
CACHE="$ROOT/var/cache/debforge/deps.cache"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][DEPS] %s\n" "$(ts)" "$*" >> "$LOG"; }

deps(){
  grep '^DEP_' "$PROJ" | cut -d= -f2- | tr ',' '\n'
}

installed(){
  dpkg -l 2>/dev/null | awk '{print $2}'
}

resolve(){
  local missing=()
  while read -r d; do
    if ! installed | grep -qx "$d"; then
      missing+=("$d")
    fi
  done
  printf "%s\n" "${missing[@]}"
}

install_deps(){
  local list=("$@")
  [ "${#list[@]}" -eq 0 ] && return
  apt-get update >> "$LOG" 2>&1
  apt-get install -y "${list[@]}" >> "$LOG" 2>&1
}

main(){
  log "start"
  local m
  mapfile -t m < <(deps | resolve)
  printf "%s\n" "${m[@]}" > "$CACHE"
  install_deps "${m[@]}"
  log "done"
}

main "$@"
