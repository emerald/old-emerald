#!/usr/bin/env bash

set -euo pipefail

# Let the user run the script from any workding directory — change the
# working directory to the script directory.
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${scriptdir}"

# Set up vmc and run vmc for empty.desc in data/
cp ../vmc data/
cd data/
./vmc empty.desc

# Run vmc and generate patches for all other .desc files in data/
run() {
  ./vmc "$1"
  ../gen-patch.sh "$1"
}

# Loop over the .desc files, allowing spaces.
IFS=$(echo -en "\n\b")
for f in *.desc
do
  if [ "$f" == "empty.desc" ]; then
    continue
  fi
  run "$f"
done
