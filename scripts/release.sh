#!/usr/bin/env bash
set -e

VERSION="$(cat VERSION 2>/dev/null || echo unknown)"
echo "Preparing release for version: $VERSION"

./scripts/lint.sh
./scripts/verify-tree.sh
./scripts/prepare-dist.sh

echo "Release preparation completed."
