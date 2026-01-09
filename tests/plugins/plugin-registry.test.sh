ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

. "$ROOT/plugins/registry.sh"

[ -d "$PLUGIN_AVAILABLE" ] || exit 1
[ -d "$PLUGIN_ENABLED" ] || exit 1
