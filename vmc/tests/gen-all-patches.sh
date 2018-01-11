#!/usr/bin/env bash

set -euo pipefail

# Let the user run the script from any working directory — change the
# working directory to wherever the script is located.
cd "$(dirname "${BASH_SOURCE[0]}")"

# Do everything from inside the data/ directory.
cd data

# Set up vmc here and run vmc for empty.desc in data/
cp ../../vmc .
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
