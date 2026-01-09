#!/usr/bin/env bash
set -e

if [ ! -f VERSION ]; then
  echo "0.0.0" > VERSION
fi

cat VERSION
