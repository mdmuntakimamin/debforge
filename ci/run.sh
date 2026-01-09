#!/usr/bin/env sh
set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CI="$(cd "$(dirname "$0")" && pwd)"

. "$CI/config/ci.conf"

sh "$CI/scripts/setup.sh"

for job in lint test build package release; do
  JOB_FILE="$CI/jobs/$job.sh"
  [ -f "$JOB_FILE" ] && sh "$JOB_FILE"
done

echo "[ci] pipeline completed"
