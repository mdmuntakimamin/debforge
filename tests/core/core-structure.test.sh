. "$(dirname "$0")/../helpers/assert.sh"

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

assert_dir_exists "$ROOT/bin"
assert_dir_exists "$ROOT/plugins"
assert_dir_exists "$ROOT/.platform"
