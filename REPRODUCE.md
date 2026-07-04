# Reproduce

This document describes the environment and protocol used for the rerun.

## Repository Layout

Clone with submodules:

```sh
git clone --recurse-submodules <this-repo-url>
cd verilogeval-rerun-results
```

The pinned upstream source is:

```text
upstream/verilog-eval
```

It is pinned to:

```text
c498220d0a52248f8e3fdffe279075215bde2da6
```

The lane-specific files are stored as overlays:

```text
overlays/direct-verilog
overlays/arch
```

The archived outputs from the completed reruns are stored under:

```text
artifacts/direct-verilog/runs/verilog
artifacts/arch/runs/arch
```

## Tool Versions

- Icarus Verilog: v12.0
- ARCH: 0.70.5
- ARCH binary: `/Users/shuqingzhao/github/arch-release-tools/v0.70.5/bin/arch`
- ARCH MCP server: `arch-hdl-release-v0705`

## Clean Codex Profile

Use an isolated Codex profile when rerunning:

```sh
export CLEAN_CODEX_HOME="$HOME/.codex-verilogeval-clean-$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$CLEAN_CODEX_HOME"
cp "$HOME/.codex/auth.json" "$CLEAN_CODEX_HOME/auth.json"
chmod 600 "$CLEAN_CODEX_HOME/auth.json"
```

For the ARCH lane, register only the released ARCH MCP server in that clean
profile:

```sh
CODEX_HOME="$CLEAN_CODEX_HOME" codex mcp add \
  --env ARCH_BIN=/Users/shuqingzhao/github/arch-release-tools/v0.70.5/bin/arch \
  --env ARCH_MCP_WORKSPACE_ROOTS=/Users/shuqingzhao/github/verilog-eval-arch \
  arch-hdl-release-v0705 \
  -- /Users/shuqingzhao/github/arch-release-tools/v0.70.5/mcp-source/arch-0.70.5/mcp/.venv/bin/python \
     /Users/shuqingzhao/github/arch-release-tools/v0.70.5/mcp-source/arch-0.70.5/mcp/arch_mcp_server.py
```

## Direct Verilog Lane

Create a lane worktree from the pinned upstream source and apply the overlay:

```sh
cp -R upstream/verilog-eval work/direct-verilog
cp -R overlays/direct-verilog/. work/direct-verilog/
cd work/direct-verilog
```

Expected summary artifacts:

- `runs/verilog/first_pass_accounting_summary.json`
- `runs/verilog/repair_accounting_summary.json`
- `runs/verilog/FINAL_REPORT.md`

Use a max repair budget of 4 attempts per failed problem.

## ARCH Lane

Create a lane worktree from the pinned upstream source and apply the overlay:

```sh
cp -R upstream/verilog-eval work/arch
cp -R overlays/arch/. work/arch/
cd work/arch
source .benchmark-env.sh
```

Expected summary artifacts:

- `first_pass_accounting_summary.json`
- `repair_accounting_summary.json`
- `FINAL_REPORT.md`

Use the `arch-programming` skill and the `arch-hdl-release-v0705` MCP workflow.
For fair comparison, cap repair accounting at 4 attempts per failed problem.

## Data Boundary

During generation and repair:

- Do not open, read, grep, summarize, diff, or infer from any `*_test.sv` or
  `*_ref.sv` file.
- Do not inspect waveforms, expected traces, backup histories, hidden checker
  logic, archived repair outputs, or prior benchmark logs.
- Icarus may receive `*_test.sv` and `*_ref.sv` only as black-box simulator
  inputs.

## Verify Archived Artifacts

From this repo root:

```sh
./scripts/check-archive.sh
```
