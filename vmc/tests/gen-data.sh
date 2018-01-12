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
