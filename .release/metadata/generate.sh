#!/usr/bin/env sh

OUT="$1"
META="$2"

mkdir -p "$META"

cat > "$META/release.info" <<EOF2
name=$RELEASE_NAME
channel=$RELEASE_CHANNEL
date=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
EOF2
