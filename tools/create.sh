#!/usr/bin/env bash

set -euo pipefail

usage() {
  echo "Usage: $0 <template> <project_name> <output_dir>" >&2
}

if [[ $# -ne 3 ]]; then
  usage
  exit 1
fi

template="$1"
project_name="$2"
output_dir="$3"

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
template_dir="${script_dir}/../templates/${template}"

if [[ ! -d ${template_dir} ]]; then
  echo "Template not found: ${template}" >&2
  exit 1
fi

if [[ -z ${project_name} ]]; then
  echo "Project name cannot be empty" >&2
  exit 1
fi

if [[ ! ${project_name} =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
  echo "Project name cannot contain any special characters" >&2
  exit 1
fi

if [[ -e ${output_dir} ]]; then
  echo "Output directory already exists: ${output_dir}" >&2
  exit 1
fi

mkdir -p "${output_dir}"

(cd "${template_dir}" && find . -type f) | while IFS= read -r file; do
  file="${file#./}"
  template_file="${template_dir}/${file}"
  target_file="${output_dir}/${file}"
  target_file=$(
    printf '%s' "${target_file}" \
      | sed -e "s/{{template\.project_name}}/${project_name}/g"
  )
  echo "${target_file}" >&2

  target_file_dir=$(dirname -- "${target_file}")
  mkdir -p "${target_file_dir}"

  sed -e "s/{{template\.project_name}}/${project_name}/g" \
    -- "${template_file}" > "${target_file}"
done

git init -- "${output_dir}"
