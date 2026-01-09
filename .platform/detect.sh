# Platform detection

detect_platform() {
  if [ -n "${TERMUX_VERSION:-}" ] || [ -d /data/data/com.termux ]; then
    echo "termux"
    return
  fi

  if [ "$(uname -s)" = "Linux" ]; then
    echo "linux"
    return
  fi

  echo "unknown"
}
