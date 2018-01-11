#!/usr/bin/env bash

set -euo pipefail

# Let the user run the script from any working directory — change the
# working directory to wherever the script is located.
cd "$(dirname "${BASH_SOURCE[0]}")"

./gen-all-patches.sh
test -z "$(git status --porcelain ./vmc/tests/data)"
