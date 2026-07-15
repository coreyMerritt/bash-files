#!/usr/bin/env bash

set -euo pipefail

script_dir="$(dirname $(readlink -f $0))"
cd $script_dir

files="$(ls -A $script_dir | grep -v install.sh | grep -v .git)"
for file in $files; do
  cp -r "${HOME}/${file}" "${HOME}/${file}.bak" 2>/dev/null || true
  cp -r "${script_dir}/${file}" "${HOME}/"
  if [[ -d "$file" ]]; then
    find "${HOME}/${file}" -name *.template -exec rm -rf {} \;
  fi
done

template_files="$(find -name *.template)"
for template_file_path in $template_files; do
  clean_template_file_path="${template_file_path#./}"
  clean_template_file_path="$(echo $clean_template_file_path | sed 's|.template||g')"
  op inject \
    --force \
    --in-file "$template_file_path" \
    --out-file "${HOME}/${clean_template_file_path}"
done
