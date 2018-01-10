#!/usr/bin/env bash

set -euo pipefail

# IMPLEMENTATION
#
# For a given path/to/file.desc, the script does the following:
#
# 1. Extracts the file component from path/to/file.desc.
# 2. Creates a temporary directory tmpdir.
# 3. Copies data/empty.desc.c, data/empty.h, and
#    data/empty.desc_i.h as file.desc.c, file.desc.h, and
#    file.desc_i.h, respectively into tmpdir.
# 4. Compares the files in tmpdir to the ones in the data directory.
# 5. Outputs the patch as path/to/file.patch.
#
# tmpdir is stripped from the path in the diff in order to generate a
# patch that can be directly applied to file.desc.c, file.desc.h,
# file.desc_i.h when they are mere copies of empty.desc.c,
# empty.desc.h, and empty.desc_i.h.

show_usage() {
  printf "Usage: bash $(basename "$0") [-h|--help] <file.desc>\n" >&$1
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

target="${path%.desc*}"

compare() (
  fst="$1"
  snd="$(basename "$2")"
  dir="$(dirname "$2")"
  cd "$dir"
  if [ $# -gt 2 ]; then
    diff -u -I "^#include \"$3\"$" "$fst" "$snd"
  else
    diff -u "$fst" "$snd"
  fi
)

compare_c() {
  compare "${1}.c" "${2}.c" \
    "\(${3}_i.h\|${4}_i.h\)"
}

compare_h() {
  compare "$1.h" "$2.h"
}

compare_i_h() {
  compare "$1_i.h" "$2_i.h" \
    "\(${3}.h\|${4}.h\)"
}

compare_all() {
  compare_c "$1" "$2" "$3" "$4"
  compare_h "$1" "$2"
  compare_i_h "$1" "$2" "$3" "$4"
}

tmpdir=$(mktemp -d)
clean() {
  rm -rf "$tmpdir"
}
trap clean EXIT HUP INT QUIT PIPE TERM

target_base="$(basename "${target}")"
origin_base="$(basename "${origin}")"

cp "${origin}.desc.c" "${tmpdir}/${target_base}.desc.c"
cp "${origin}.desc.h" "${tmpdir}/${target_base}.desc.h"
cp "${origin}.desc_i.h" "${tmpdir}/${target_base}.desc_i.h"

compare_all \
    "${tmpdir}/${target_base}.desc" "${target}.desc" \
    "${origin_base}.desc" "${target_base}.desc" | \
  perl -pe \
    's/^((---|\+\+\+) [^\t]+)\t.*/\1\t2018-01-01 00:00:00.000000000 +0100/' | \
  perl -pe \
    's/^--- \/(.*\/)*/--- /' \
  > "${target}.patch"
