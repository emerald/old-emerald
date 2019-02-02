#!/usr/bin/env bash

# Generate the list of Builtins, according to the export declarations
# in .m files under ../Builtins.
#
# The algorithm:
#
#   1. Find declarations of the form export <list> to "Builtins".
#   2. Extract the <list> part.
#   3. Split the list up (it is comma-separated)
#   4. Sort and show unique names in a case-insensitive manner.

set -euo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
builtins="${dir}/../Builtins/"

cd "${builtins}"

find . -iname "*.m" \
  -exec grep -E "export.*to\s*\"Builtins\"" {} \; | \
  perl -pe "s/export\s+(.*)\s+to\s+\"Builtins\"/\1/" | \
  perl -pe "s/,\s+/\n/g" | \
  sort --ignore-case | uniq --ignore-case
