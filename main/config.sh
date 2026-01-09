# Configuration loader

load_config() {
  [ -f "./config.env" ] && . ./config.env
}
