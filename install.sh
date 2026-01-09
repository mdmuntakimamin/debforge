#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
BIN="$ROOT/bin"
VAR="$ROOT/var"
ETC="$ROOT/etc"
ENV="$ROOT/env"
CORE="$ROOT/core"
LIB="$ROOT/lib"
HOOKS="$ROOT/hooks"
FORMATS="$ROOT/formats"

PREFIX="$PREFIX"
TARGET="$PREFIX/bin"

die(){ echo "[INSTALL][FATAL] $1"; exit 1; }

mkdirs(){
  mkdir -p \
    "$BIN" "$VAR/cache/debforge" "$VAR/lib/debforge/state" \
    "$VAR/run/debforge" "$VAR/lock" "$VAR/spool/debforge" \
    "$ETC/debforge" "$ETC/defaults" "$ETC/profiles" \
    "$ENV" "$CORE" "$LIB" "$HOOKS" "$FORMATS"
}

install_bins(){
  for f in "$BIN"/debforge*; do
    [ -x "$f" ] || continue
    ln -sf "$f" "$TARGET/$(basename "$f")"
  done
}

permissions(){
  find "$ROOT" -type f -name "*.sh" -exec chmod 755 {} +
  find "$BIN" -type f -exec chmod 755 {} +
}

sanity(){
  command -v dpkg >/dev/null || die "dpkg not found"
  command -v tar >/dev/null || die "tar not found"
}

main(){
  sanity
  mkdirs
  permissions
  install_bins
  echo "[INSTALL] DebForge installed"
  echo "[INSTALL] Version: $(cat "$ROOT/VERSION")"
}

main
