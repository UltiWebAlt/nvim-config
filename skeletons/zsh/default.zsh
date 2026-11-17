#!/usr/bin/env zsh
set -Eeuo pipefail
# Author: ${author}
# Date: ${mdY}

on_err() {
  local rc=$?
  printf 'ERROR: line %s: %s (exit %s)\n' "${BASH_LINENO[0]}" "$BASH_COMMAND" "$rc" >&2
}

if [[ "${ZSH_DEBUG:-0}" != "1" ]]; then
  trap 'on_err' ERR
fi

exec 1> >(logger -s -t "$(basename "$0")") 2>&1

${cursor}

