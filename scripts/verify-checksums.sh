#!/usr/bin/env sh
set -eu

cd "$(dirname "$0")/.."
shasum -a 256 -c checksums.sha256

