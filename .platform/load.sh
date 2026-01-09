# Platform loader

set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

. "$ROOT/.platform/detect.sh"

PLATFORM="$(detect_platform)"

PLATFORM_FILE="$ROOT/.platform/platforms/$PLATFORM.sh"

if [ -f "$PLATFORM_FILE" ]; then
  . "$PLATFORM_FILE"
else
  . "$ROOT/.platform/platforms/unknown.sh"
fi
