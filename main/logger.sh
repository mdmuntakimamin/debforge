log() {
  echo "[debforge] $*"
}

debug() {
  [ "$DEBFORGE_DEBUG" = "1" ] && echo "[debug] $*"
}
