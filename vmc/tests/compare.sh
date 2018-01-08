#!/usr/bin/env bash

set -euo pipefail

fst="${1%.desc*}"
snd="${2%.desc*}"

function compare {
  if [ $# -gt 2 ]; then
    diff -u -I "^#include \"$3\"$" "$1" "$2"
  else
    diff -u "$1" "$2"
  fi
}

function compare_c {
  compare "${1}.c" "${2}.c" \
    "\(${3}_i.h\|${4}_i.h\)"
}

function compare_h {
  compare "$1.h" "$2.h"
}

function compare_i_h {
  compare "$1_i.h" "$2_i.h" \
    "\(${3}.h\|${4}.h\)"
}

function compare_all {
  base1="$(basename "$1")"
  base2="$(basename "$2")"
  compare_c "$1" "$2" "$base1" "$base2"
  compare_h "$1" "$2"
  compare_i_h "$1" "$2" "$base1" "$base2"
}

compare_all "${fst}.desc" "${snd}.desc"
