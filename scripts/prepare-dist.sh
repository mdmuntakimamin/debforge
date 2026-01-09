#!/usr/bin/env bash
set -e

DIST="dist"
mkdir -p "$DIST"

echo "Preparing distribution archive..."

tar -cJf "$DIST/debforge.tar.xz" \
  bin core docs scripts VERSION install.sh uninstall.sh 2>/dev/null || true

echo "Distribution ready: $DIST/debforge.tar.xz"
