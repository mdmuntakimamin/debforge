#!/usr/bin/env sh

set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TEST_DIR="$ROOT/tests"
FAIL=0

echo "[TEST] running test suite"

for test in $(find "$TEST_DIR" -type f -name "*.test.sh"); do
  echo "[TEST] $(basename "$test")"
  sh "$test" || FAIL=1
done

if [ "$FAIL" -eq 0 ]; then
  echo "[TEST] all tests passed"
else
  echo "[TEST] failures detected"
fi

exit "$FAIL"
