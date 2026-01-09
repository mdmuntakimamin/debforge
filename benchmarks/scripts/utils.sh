now_ms() {
  date +%s%3N 2>/dev/null || echo "$(date +%s)000"
}

result() {
  echo "$1=$2" >> "$OUT"
}
