assert_file_exists() {
  [ -f "$1" ] || {
    echo "ASSERT FAILED: file missing: $1"
    return 1
  }
}

assert_dir_exists() {
  [ -d "$1" ] || {
    echo "ASSERT FAILED: dir missing: $1"
    return 1
  }
}

assert_command() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "ASSERT FAILED: command missing: $1"
    return 1
  }
}
