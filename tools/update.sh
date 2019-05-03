#!/bin/sh
set -euo pipefail

# https://stackoverflow.com/a/246128/4396258
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CISTERN="$(dirname "${SCRIPT_DIR}")"

pushd $CISTERN
pwd
git pull origin master
make run
