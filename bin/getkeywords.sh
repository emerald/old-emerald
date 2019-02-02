#!/usr/bin/env bash

# Generate the list of keywords in Emerald, according to `parsedef.m`
# and `tokNames.m` under ../EC. Together, these two files declare the
# keywords in Emerald as follows:
#
#   * `parsedef.m` declares an Emerald constant for each keyword.
#      The keyword constants begin with the letter 'K', and continue
#      with the keyword in all caps. For instance, `KRETURN` for the
#      keyword "return".
#
#   * `tokNames.m` declares an Emerald array of strings, where the
#      offset of each keyword corresponds to the constant value it
#      gets above.
#
# This script assumes more simply, that the keywords in `paraedef.m`
# occur in the same order as in `tokNames.m`. However, this script
# does fail if that assumption does not hold.
#
# The algorithm:
#
#   1. Combine parsedef.m and tokNames.m into one file, skipping the
#      first line of tokNames.m.
#   2. Extract only those lines that declare keywords (const K..).
#   3. From each line, extract the keyword constant suffix, and the
#      keyword string (without quotes).
#   4. Make sure the keyword constant suffix corresponds to the
#      keyword string, lest the casing.
#   5. If all looks well, list the keyword strings found above.

set -euo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ecpath="${dir}/../EC/"

cd "${ecpath}"

regex="^\\s+const\\s+K([A-Z]+)\\s+<-\\s+[0-9]+\\s+\"([a-z]+)\",$"

raw="$( \
  paste parsedef.m <(tail -n +2 tokNames.m) | \
    egrep "${regex}" )"

good="$( \
  echo "${raw}" | \
    perl -pe "s/${regex}/\1 \2/" )"

n_lines="$( \
  echo "${good}" | \
    wc -l )"

uniq="$( \
  echo "${good}" | \
    tr ' ' '\n' | \
    uniq -i )"

n_uniq="$( \
  echo "${uniq}" | \
    wc -l )"

if [ ${n_lines} != ${n_uniq} ]; then
  printf "Looks like someone broke the keyword definition conventions.." >&2
  printf "Refusing to generate the list of keywords." >&2
  exit 1
fi

echo "${good}" | cut -d' ' -f2
