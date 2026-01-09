ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

[ -f "$ROOT/plugins/load.sh" ] || exit 1
[ -f "$ROOT/.platform/load.sh" ] || exit 1
