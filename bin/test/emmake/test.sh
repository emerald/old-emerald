#!/usr/bin/env bash

set -euo pipefail

failed() {
  if [ $? != 0 ]; then
    printf "Test failed :-(\n" >&2
  fi
}

trap 'failed' EXIT INT TERM

find2d() {
  find -mindepth 2 -maxdepth 2 $@
}

quiet="$(find2d -iname "quiet.txt")"
verbose="$(find2d -iname "verbose.txt")"
all="$quiet $verbose"

test_failed_in() {
  printf "Test of ${1} failed in ${2} failed :-(\n" >&2
}

test_path() (
  path=${1}
  shift

  dirname="$(dirname "${path}")"
  basename="$(basename "${path}")"

  printf "Testing with the %s directory..\n" "${dirname}"

  cd "${dirname}"

  expected_exitcode=$(cat exitcode.txt | tr -d '[:blank:]')

  set +e
  set -x
  EMERALDROOT=. EMERALDARCH=i686 \
    ../../../emmake $@ > "${basename}" 2>&1
  actual_exitcode=$?
  set +x
  set -e

  if [ $actual_exitcode != $expected_exitcode ]; then
    test_failed_in "${basename}" "${dirname}"
    printf "Unexpected exitcode from emmake.\n" >&2
    exit 1
  fi

  n_status_lines=$(git status --porcelain . | wc -l )
  if [ $n_status_lines != 0 ]; then
    test_failed_in "${basename}" "${dirname}"
    printf "Unexpected changes in directorty.\n" >&2
    git status .
    exit 1
  fi
)

test_quiet() {
  for f in ${quiet}; do
    test_path "$f"
  done
}

test_verbose() {
  for f in ${verbose}; do
    test_path "$f" -v
  done
}

all() {
  test_quiet
  test_verbose
}

clean() {
  git checkout $all
}

error() {
  printf "%s" "$1" >&2
  exit 1
}

if [ $# -gt 0 ]; then
  case "$1" in
    clean ) clean;;
    * ) error "Unsupported argument ${1}." 
  esac
else
  all
fi
