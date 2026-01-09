#!/usr/bin/env bash
set -e

REQUIRED_DIRS="bin core docs scripts"

for d in $REQUIRED_DIRS; do
  if [ ! -d "$d" ]; then
    echo "Missing directory: $d"
    exit 1
  fi
done

echo "Project structure verified."
