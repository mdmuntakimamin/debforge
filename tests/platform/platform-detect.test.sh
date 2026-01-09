ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

. "$ROOT/.platform/detect.sh"

PLATFORM="$(detect_platform)"

[ -n "$PLATFORM" ] || {
  echo "Platform detection failed"
  exit 1
}
