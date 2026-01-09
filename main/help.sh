show_help() {
  cat <<EOT
Usage: verpkg <command> [options]

Commands:
  build        Build the project
  clean        Clean outputs
  test         Run tests
  release      Prepare release
  ci           Run CI pipeline

Options:
  --debug      Enable debug output
  --no-color   Disable colored output
EOT
}
