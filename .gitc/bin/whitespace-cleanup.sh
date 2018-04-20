#!/bin/sh

set -e

path=$1
sed -i 's/^\t/        /' "$path"
sed -i 's/\t/  /' "$path"
sed -i 's/\s\+$//' "$path"
