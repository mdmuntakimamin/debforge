# Termux platform loader

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

if [ -f "$ROOT/.termux/env.sh" ]; then
  . "$ROOT/.termux/env.sh"
fi

export DEBFORGE_PLATFORM="termux"
