#!/usr/bin/env bash

set -euo pipefail

script_dir="$(dirname $(readlink -f $0))"

files="$(ls -A $script_dir | grep -v install.sh)"

for file in $files; do
  cp -r "${HOME}/${file}" "${HOME}/${file}.bak" 2>/dev/null || true
  cp -r "${script_dir}/${file}" "${HOME}/"
done
