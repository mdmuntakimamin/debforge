#!/usr/bin/env sh

set -e

[ -d bin ] || { echo "bin missing"; exit 1; }
[ -d plugins ] || { echo "plugins missing"; exit 1; }
[ -d .platform ] || { echo ".platform missing"; exit 1; }
