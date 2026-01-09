#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
STATE="$ROOT/var/lib/debforge/state/build.state"
PROJ="$ROOT/var/lib/debforge/project.db"
LOG="$ROOT/logs/versioning.log"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][VERSION] %s\n" "$(ts)" "$*" >> "$LOG"; }

read_kv(){
  grep -E "^$1=" "$PROJ" | cut -d= -f2-
}

write_kv(){
  sed -i "/^$1=/d" "$PROJ"
  printf "%s=%s\n" "$1" "$2" >> "$PROJ"
}

git_version(){
  git describe --tags --dirty --always 2>/dev/null || true
}

hash_version(){
  find "$ROOT/src" -type f -exec sha256sum {} + 2>/dev/null | sha256sum | cut -c1-12
}

time_version(){
  date +%Y%m%d%H%M%S
}

compose_version(){
  local base gitv hv tv
  base="$(read_kv PROJECT_VERSION || echo 0.1.0)"
  gitv="$(git_version)"
  hv="$(hash_version)"
  tv="$(time_version)"
  if [ -n "$gitv" ]; then
    printf "%s+git.%s.%s\n" "$base" "$gitv" "$hv"
  else
    printf "%s+build.%s.%s\n" "$base" "$tv" "$hv"
  fi
}

main(){
  log "start"
  local v
  v="$(compose_version)"
  write_kv PROJECT_VERSION "$v"
  printf "VERSION=%s\nTIME=%s\n" "$v" "$(date +%s)" >> "$STATE"
  log "version=$v"
}

main "$@"
