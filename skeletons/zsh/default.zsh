#!/usr/bin/env zsh
set -Eeuo pipefail
# Author: ${author}
# Date: ${mdY}

if [[ "${ZSH_DEBUG:-0}" != "1" ]]; then
  last_line=0
  last_command=''
  trap 'last_line=$LINENO; last_command=$ZSH_DEBUG_CMD' DEBUG
  trap 'rc=$?; printf "ERROR: line %s: %s (exit %s)\\n" "$last_line" "$last_command" "$rc" >&2' ERR
fi

exec 1> >(logger -s -t "$(basename "$0")") 2>&1

${cursor}

