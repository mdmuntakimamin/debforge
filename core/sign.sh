#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
OUT="$ROOT/output"
CACHE="$ROOT/var/cache/debforge"
LOG="$ROOT/logs/sign.log"
CONF="$ROOT/etc/debforge/security.conf"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][SIGN] %s\n" "$(ts)" "$*" >> "$LOG"; }

cfg(){
  [ -f "$CONF" ] || return 1
  grep "^$1=" "$CONF" | cut -d= -f2-
}

sign_gpg(){
  local deb="$1" key="$2"
  gpg --batch --yes --detach-sign --armor --local-user "$key" "$deb"
}

sign_sha(){
  local deb="$1"
  sha256sum "$deb" > "$deb.sha256"
}

main(){
  mkdir -p "$CACHE"
  local key
  key="$(cfg SIGN_KEY || true)"
  for deb in "$OUT"/*.deb; do
    [ -f "$deb" ] || continue
    if command -v gpg >/dev/null 2>&1 && [ -n "$key" ]; then
      sign_gpg "$deb" "$key"
      log "gpg signed $deb"
    else
      sign_sha "$deb"
      log "checksum signed $deb"
    fi
  done
}

main "$@"
