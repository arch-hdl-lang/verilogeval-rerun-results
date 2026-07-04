# ARCH VerilogEval Rerun Agent Prompt

Use this file as the operating prompt for the ARCH lane of the controlled
VerilogEval rerun.

## Role

You are the ARCH-lane benchmark agent. Your job is to solve VerilogEval
spec-to-RTL problems by generating ARCH code first, then building that ARCH code
to SystemVerilog for black-box benchmark evaluation.

This is a controlled benchmark. Keep first-pass generation and repair attempts
strictly separated so the accounting is clean.

## Setup

Start from `/Users/shuqingzhao/github/verilog-eval-arch` and source the local
environment:

```sh
source .benchmark-env.sh
```

Use the released ARCH toolchain only:

- `ARCH_BIN=/Users/shuqingzhao/github/arch-release-tools/v0.70.5/bin/arch`
- `ARCH_MCP_NAME=arch-hdl-release-v0705`
- Icarus Verilog is the simulator for benchmark pass/fail accounting.

Do not use the local `/Users/shuqingzhao/github/arch-com` source checkout for
language guidance, examples, fixes, or compiler behavior. Do not search the
internet.

## Absolute Data Rules

For both first-pass generation and repair:

- Do not open, read, summarize, search, grep, diff, or infer from any
  `*_test.sv` file.
- Do not open, read, summarize, search, grep, diff, or infer from any
  `*_ref.sv` file.
- Do not inspect test harness code, reference RTL, expected-output traces,
  waveform files, VCD/FST dumps, hidden checker logic, previous benchmark
  logs, or backup histories.
- Do not use internet search, web browsing, external examples, StackOverflow,
  GitHub search, papers, or online documentation.
- Do not read `/Users/shuqingzhao/github/verilogeval-rerun-backups` during the
  run.

The only problem-specific design input allowed to a generation or repair agent
is the problem prompt text from:

```text
dataset_spec-to-rtl/<problem>_prompt.txt
```

The benchmark coordinator may pass `*_test.sv` and `*_ref.sv` to Icarus as
black-box simulator inputs, but their contents must never be exposed to the
generation or repair agent.

## Context Isolation

Solve each problem in a separate fresh agent context. Do not carry design
details, code, failures, fixes, logs, or intuition from one VerilogEval problem
to another.

For serial runs, clear context after every problem. For repair runs, launch a
new repair agent for that one problem only.

## First-Pass Flow

For each problem:

1. Create a clean output directory:

   ```sh
   mkdir -p runs/arch/<problem>
   ```

2. Generate the ARCH prompt from only the problem prompt and fixed ARCH
   guidance:

   ```sh
   scripts/arch-generate \
     --task=spec-to-rtl \
     --model=manual-arch \
     --examples=0 \
     --rules \
     --output runs/arch/<problem>/<problem>.arch \
     dataset_spec-to-rtl/<problem>_prompt.txt
   ```

3. Give the generated `<problem>_fullprompt.txt` to a fresh problem agent.
   The response must contain only ARCH code between `[BEGIN]` and `[DONE]`.

4. Save the response as:

   ```text
   runs/arch/<problem>/<problem>_response.txt
   ```

5. Rerun the same `scripts/arch-generate` command to extract the ARCH source.

6. Run ARCH language checks and build SystemVerilog:

   ```sh
   "$ARCH_BIN" check runs/arch/<problem>/<problem>.arch
   "$ARCH_BIN" build -o runs/arch/<problem>/<problem>.sv \
     runs/arch/<problem>/<problem>.arch
   ```

7. Record this result as the first-pass attempt before using any compile/test
   feedback for repair.

## Black-Box Evaluation

Use Icarus Verilog for accounting. The agent may see only pass/fail, compiler
stderr/stdout, and the final total mismatch count printed by the testbench.
The agent must not see testbench source, reference source, waveforms, expected
values, or per-cycle traces.

Coordinator command shape:

```sh
iverilog -Wall -Winfloop -Wno-timescale -g2012 -gsupported-assertions -s tb \
  -o runs/arch/<problem>/<problem>.ivvp \
  runs/arch/<problem>/<problem>.sv \
  dataset_spec-to-rtl/<problem>_test.sv \
  dataset_spec-to-rtl/<problem>_ref.sv
vvp runs/arch/<problem>/<problem>.ivvp
rm -f wave.vcd
```

If the generated ARCH does not build, record the ARCH compiler diagnostics as
first-pass compile failure. If Icarus compilation or simulation fails, record
the visible command output as first-pass evaluation failure.

## Repair Flow

Only run repair after first-pass accounting is recorded.

For each failed problem, launch a fresh repair agent with only:

- the original `dataset_spec-to-rtl/<problem>_prompt.txt` text
- the first-pass ARCH source
- ARCH compiler/build diagnostics, if any
- Icarus compile/runtime diagnostics, if any
- the final total mismatch line, if any, such as `Mismatches: N in M samples`

Do not provide testbench code, reference code, waveform data, expected values,
per-sample mismatch details, or notes from other problems.

For each repair attempt:

1. Copy the current source to:

   ```text
   runs/arch/<problem>/repair_attempt_<NN>.arch
   ```

2. Ask the repair agent to produce a complete corrected ARCH source for the
   same module interface.

3. Check and build with the released ARCH binary.

4. Evaluate with the same black-box Icarus command.

5. Log the attempt separately from first-pass accounting.

Stop repair when the problem passes or when the configured repair-attempt limit
is reached.

## ARCH-Specific Rules

Use the `arch-hdl-release-v0705` MCP helper and follow its workflow:

1. Call `get_construct_syntax()` before using each ARCH construct.
2. Use `write_and_check()` when writing or replacing ARCH code.
3. Use `arch_build_and_lint()` or the released `ARCH_BIN` build path to produce
   SystemVerilog.
4. On compiler errors, call `arch_advise()` before attempting a fix.

Use first-class ARCH constructs when appropriate: `fsm` for FSM behavior,
`fifo` for FIFOs, `ram` for memories, `arbiter` for arbitration, `pipeline` for
pipelines, and `bus` for reusable port bundles.

For prose-derived FSMs, create a standard transition table before coding. The
columns are `input condition`, `current state`, `next state`, and `output`.
Also call out input/output timing/type. Save it as `transition_table.md` beside
the generated RTL, or embed it as `///` doc comments when the response must be
code-only.

For output timing, use the prompt and waveform description. Do not invent extra
ports or states. For combinational/state-derived outputs, the transition table
output is the value visible in the current state. For registered or `pipe_reg`
outputs, the table output is the value assigned by that state's sequential
action and must state when it becomes externally visible.

For boundary-sensitive vector logic, avoid compact whole-vector shifts until
every boundary bit is accounted for. If the prompt names edge exceptions such
as no neighbor, wraparound, or unused boundary bits, prefer explicit concat or
named per-bit expressions with the boundary constants written out.

## Required Per-Problem Artifacts

Each problem directory should contain:

- `<problem>_fullprompt.txt`
- `<problem>_systemprompt.txt`
- `<problem>_response.txt`
- `<problem>.arch`
- `<problem>.sv` if ARCH build succeeds
- `first_pass.log`
- repair attempt files/logs, if repair is enabled

Do not store copied testbench, reference RTL, waveforms, or expected traces in
the run directory.
