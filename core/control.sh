#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$HOME/debforge-aarch64"
FMT="$ROOT/formats"
DEF="$ROOT/etc/defaults/control.defaults"
PROJ="$ROOT/var/lib/debforge/project.db"
STAGE="$ROOT/runtime/stage"
LOG="$ROOT/logs/control.log"

ts(){ date +"%Y-%m-%d %H:%M:%S"; }
log(){ printf "[%s][CONTROL] %s\n" "$(ts)" "$*" >> "$LOG"; }

load_defaults(){
  declare -gA D
  while IFS='=' read -r k v; do
    [ -n "$k" ] && D["$k"]="$v"
  done < "$DEF"
}

load_project(){
  declare -gA P
  while IFS='=' read -r k v; do
    [ -n "$k" ] && P["$k"]="$v"
  done < "$PROJ"
}

emit(){
  local k="$1" v="$2"
  printf "%s: %s\n" "$k" "$v"
}

build_control(){
  mkdir -p "$STAGE/DEBIAN"
  local ctl="$STAGE/DEBIAN/control"
  : > "$ctl"
  emit Package        "${P[PROJECT_NAME]:-${D[Package]}}"        >> "$ctl"
  emit Version        "${P[PROJECT_VERSION]:-${D[Version]}}"     >> "$ctl"
  emit Section        "${D[Section]}"                             >> "$ctl"
  emit Priority       "${D[Priority]}"                            >> "$ctl"
  emit Architecture   "${P[BUILD_ARCH]:-${D[Architecture]}}"     >> "$ctl"
  emit Essential      "${D[Essential]}"                           >> "$ctl"
  emit Maintainer     "${P[PROJECT_MAINTAINER]:-${D[Maintainer]}}" >> "$ctl"
  emit Homepage       "${P[PROJECT_URL]:-${D[Homepage]}}"         >> "$ctl"
  emit Depends        "${P[DEP_RUN]:-${D[Depends]}}"              >> "$ctl"
  emit Description    "${P[PROJECT_DESC]:-${D[Description]}}"    >> "$ctl"
}

main(){
  log "start"
  load_defaults
  load_project
  build_control
  log "done"
}

main "$@"
