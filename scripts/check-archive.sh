#!/usr/bin/env sh
set -eu

cd "$(dirname "$0")/.."

./scripts/verify-checksums.sh

upstream_commit=$(git -C upstream/verilog-eval rev-parse HEAD)
expected_commit=c498220d0a52248f8e3fdffe279075215bde2da6
if [ "$upstream_commit" != "$expected_commit" ]; then
  echo "Unexpected upstream/verilog-eval commit: $upstream_commit" >&2
  exit 1
fi

bad_files=$(find artifacts overlays -type f \( -name '*_test.sv' -o -name '*_ref.sv' -o -name 'wave.vcd' \) -print)
if [ -n "$bad_files" ]; then
  echo "Unexpected hidden-eval or waveform files in archive:" >&2
  echo "$bad_files" >&2
  exit 1
fi

test "$(find artifacts/direct-verilog/runs/verilog -maxdepth 2 -type f -name 'first_pass.log' | wc -l | tr -d ' ')" = "156"
test "$(find artifacts/arch/runs/arch -maxdepth 2 -type f -name 'first_pass.log' | wc -l | tr -d ' ')" = "156"

echo "Archive check OK"
