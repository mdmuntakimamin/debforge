plugin_run() {
  echo "[plugin:checksum] generating checksums"

  for f in *.tar.xz *.deb 2>/dev/null; do
    [ -f "$f" ] && sha256sum "$f" > "$f.sha256"
  done
}
