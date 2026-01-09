parse_args() {
  for arg in "$@"; do
    case "$arg" in
      --debug) export DEBFORGE_DEBUG=1 ;;
      --no-color) export DEBFORGE_COLOR=0 ;;
    esac
  done
}
