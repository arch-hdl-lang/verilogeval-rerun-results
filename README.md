# VerilogEval Rerun Results

This repository archives a controlled rerun comparing two VerilogEval
spec-to-RTL lanes:

- Direct SystemVerilog generation and repair.
- ARCH HDL generation and repair, built to SystemVerilog before black-box
  Icarus evaluation.

The result files here are small, auditable summaries. The runnable lane
workspaces are expected to be published separately or added as pinned
submodules before an external release.

## Headline Results

| Lane | First pass | Repair budget | Final result | Unrepaired under fair budget |
| --- | ---: | ---: | ---: | --- |
| Direct Verilog | 133 / 156 | max 4 attempts | 152 / 156 | Prob082_lfsr32, Prob099_m2014_q6c, Prob141_count_clock, Prob156_review2015_fancytimer |
| ARCH HDL | 148 / 156 | max 4 attempts | 154 / 156 | Prob066_edgecapture, Prob099_m2014_q6c |

The ARCH lane also has an all-recorded-attempts view: `155 / 156`, because
`Prob066_edgecapture` passed on `repair_attempt_07`. For fair comparison to the
direct-Verilog run, this repository uses the max-4 repair budget result.

## Contents

- `reports/direct-verilog/`: direct-Verilog final report and accounting JSON.
- `reports/arch/`: ARCH final report and accounting JSON.
- `manifests/`: machine-readable lane metadata.
- `checksums.sha256`: SHA256 checksums for archived report artifacts.
- `REPRODUCE.md`: rerun instructions.
- `COMPARISON.md`: comparison notes and interpretation.

## Integrity

Verify archived report artifacts:

```sh
./scripts/verify-checksums.sh
```

## Benchmark Rules

Both lanes used the same benchmark data boundaries:

- Do not read `*_test.sv` or `*_ref.sv` contents.
- Pass test/reference files to Icarus only as black-box simulator inputs.
- Record first-pass accounting before repair.
- Use fresh independent context for each problem and for each repair worker.
- Do not inspect archived prior repair outputs, waveforms, backup histories, or
  hidden checker logic.

