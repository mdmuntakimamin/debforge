plugin_run() {
  echo "[plugin:lint] running basic checks"

  find . -type f -name "*.sh" -exec shellcheck {} \; 2>/dev/null || true
}
