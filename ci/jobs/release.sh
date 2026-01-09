#!/usr/bin/env sh
set -e

echo "[ci] release stage"

[ -d .release ] && sh .release/prepare.sh
