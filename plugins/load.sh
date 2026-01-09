# Plugin loader

set -e

. "$(dirname "$0")/registry.sh"

run_hook() {
  hook="$1"
  hook_dir="$PLUGIN_HOOKS/$hook.d"

  [ -d "$hook_dir" ] || return 0

  for script in "$hook_dir"/*; do
    [ -x "$script" ] && "$script"
  done
}

load_plugins() {
  for plugin in "$PLUGIN_ENABLED"/*; do
    [ -d "$plugin" ] || continue

    conf="$plugin/plugin.conf"
    impl="$plugin/plugin.sh"

    [ -f "$conf" ] && . "$conf"
    [ -f "$impl" ] && . "$impl"
  done
}
