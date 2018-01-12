#!/usr/bin/env bash

# Copyright 2017 Oleks <oleks@oleks.info>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

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

  args=(-u)
  if [ $# -gt 2 ]; then
    args[1]=-I
    args[2]="^#include \"$3\"$"
  fi

  cd "$dir"
  set +e
  diff "${args[@]}" "$fst" "$snd"
  exitcode=$?
  set -e
  if [ $exitcode -ne 0 ] && [ $exitcode -ne 1 ]; then
    exit $exitcode
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
    's/^--- (")?\/(.*\/)*([^\t]+"?\t)/--- \1\3/' \
  > "${target}.patch"
