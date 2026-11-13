#!/usr/bin/env bash
set -Eeuo pipefail
# Author: ${author}
# Date: ${mdY}

if [[ ${BASH_DEBUG:-0} != 1 ]]; then
  trap 'rc=$?; printf "ERROR: line %s: %s (exit %s)\n" "$LINENO" "$BASH_COMMAND" "$rc" >&2' ERR
fi

exec 1> >(logger -s -t $(basename "$0")) 2>&1

${cursor}
