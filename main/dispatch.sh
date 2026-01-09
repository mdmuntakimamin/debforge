#!/usr/bin/env sh

set -e

CMD="$1"
shift || true

case "$CMD" in
  build)    sh scripts/build.sh "$@" ;;
  clean)    sh scripts/clean.sh ;;
  test)     sh tests/run.sh ;;
  release)  sh .release/prepare.sh ;;
  ci)       sh ci/run.sh ;;
  *)
    echo "Unknown command: $CMD"
    exit 1
    ;;
esac
