#!/usr/bin/env bash

fst="${1%.desc*}"
snd="${2%.desc*}"

function compare {
  diff -ruN "$1" "$2"
}

function compare_c {
  compare "$1.c" "$2.c"
}

function compare_h {
  compare "$1.h" "$2.h"
}

function compare_i_h {
  compare_h "$1_i" "$2_i"
}

function compare_all {
  compare_c "$1" "$2"
  compare_h "$1" "$2"
  compare_i_h "$1" "$2"
}

compare_all "${fst}.desc" "${snd}.desc"
