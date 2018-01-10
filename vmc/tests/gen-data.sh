#!/usr/bin/env bash

set -euo pipefail

show_usage() {
  printf "Usage: bash $(basename "$0") [-h|--help] <file.patch>\n" >&$1
}

if [ $# -eq 0 ]; then
  show_usage 2
  exit 1
elif [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  show_usage 1
  exit 0
fi

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

origin="${scriptdir}/data/empty"

path="$(realpath "$1")"

base="${path%.patch*}"

if [ ! -f "${path}" ] || \
    [ "$(file --mime-type "${path}" | cut -d':' -f2)" != " text/x-diff" ]; then
  echo "${path} is not a patch file."
  exit 1
fi

cp "${origin}.desc.c" "${base}.desc.c"
cp "${origin}.desc.h" "${base}.desc.h"
cp "${origin}.desc_i.h" "${base}.desc_i.h"

dir="$(dirname "${origin}")"
relpath="$(realpath --relative-to="$dir" "${base}.patch")"

cd "$dir"
patch --quiet -p0 < "$relpath"
