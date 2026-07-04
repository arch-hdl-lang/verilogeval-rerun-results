# VerilogEval Clean Repair Run Final Report

Date: 2026-07-03

Repository: `/Users/shuqingzhao/github/verilog-eval-verilog`

## Protocol

- This report summarizes the active clean-session artifacts under `runs/verilog`.
- Evidence checked: `first_pass_accounting_summary.json`, `repair_accounting_summary.json`, and active first-pass/repair logs.
- Excluded from inspection: `*_test.sv`, `*_ref.sv`, and archived repair directories.
- The repair run was reported as using one fresh independent worker per first-pass failed problem.
- Icarus Verilog was used only as black-box evaluation.

## Headline Results

Repository-evaluator accounting result:

- Total problems: 156
- First-pass passed: 133 / 156
- First-pass failed: 23 / 156
- Repaired after first pass: 19 / 23
- Final effective passed: 152 / 156
- Final unrepaired: 4 / 156
- Total repair attempts: 36
- Tokens used by clean run: 209,529, as reported by the run

First-pass failure breakdown:

| Status | Count |
| --- | ---: |
| Compile failure | 10 |
| Mismatch | 10 |
| Timeout | 3 |

Repair outcome breakdown:

| Status | Count |
| --- | ---: |
| Pass | 19 |
| Timeout | 3 |
| Compile failure | 1 |

## First-Pass Failures and Repair Outcomes

| Problem | First-pass status | Attempts | Repair status | Passing attempt |
| --- | --- | ---: | --- | ---: |
| Prob009_popcount3 | compile_fail | 1 | pass | 1 |
| Prob034_dff8 | mismatch | 1 | pass | 1 |
| Prob053_m2014_q4d | mismatch | 1 | pass | 1 |
| Prob062_bugs_mux2 | mismatch | 1 | pass | 1 |
| Prob066_edgecapture | mismatch | 1 | pass | 1 |
| Prob070_ece241_2013_q2 | mismatch | 1 | pass | 1 |
| Prob082_lfsr32 | timeout | 1 | timeout | - |
| Prob093_ece241_2014_q3 | mismatch | 4 | pass | 4 |
| Prob099_m2014_q6c | compile_fail | 4 | compile_fail | - |
| Prob104_mt2015_muxdff | mismatch | 1 | pass | 1 |
| Prob131_mt2015_q4 | compile_fail | 1 | pass | 1 |
| Prob133_2014_q3fsm | compile_fail | 1 | pass | 1 |
| Prob136_m2014_q6 | compile_fail | 1 | pass | 1 |
| Prob139_2013_q2bfsm | compile_fail | 1 | pass | 1 |
| Prob140_fsm_hdlc | compile_fail | 1 | pass | 1 |
| Prob141_count_clock | timeout | 4 | timeout | - |
| Prob146_fsm_serialdata | mismatch | 1 | pass | 1 |
| Prob147_circuit10 | mismatch | 1 | pass | 1 |
| Prob149_ece241_2013_q4 | compile_fail | 2 | pass | 2 |
| Prob151_review2015_fsm | compile_fail | 1 | pass | 1 |
| Prob154_fsm_ps2data | mismatch | 2 | pass | 2 |
| Prob155_lemmings4 | compile_fail | 1 | pass | 1 |
| Prob156_review2015_fancytimer | timeout | 3 | timeout | - |

## Repair Attempt Counts

Aggregate attempt statistics:

| Metric | Count |
| --- | ---: |
| Total repaired-problem candidates | 23 |
| Total repair attempts | 36 |
| Attempts spent on ultimately passing repairs | 24 |
| Attempts spent on unrepaired problems | 12 |

Attempt-count distribution:

| Attempts for a problem | Problems |
| ---: | ---: |
| 1 | 17 |
| 2 | 2 |
| 3 | 1 |
| 4 | 3 |

Per-problem attempt counts:

| Problem | Attempts | Repair status | Passing attempt |
| --- | ---: | --- | ---: |
| Prob009_popcount3 | 1 | pass | 1 |
| Prob034_dff8 | 1 | pass | 1 |
| Prob053_m2014_q4d | 1 | pass | 1 |
| Prob062_bugs_mux2 | 1 | pass | 1 |
| Prob066_edgecapture | 1 | pass | 1 |
| Prob070_ece241_2013_q2 | 1 | pass | 1 |
| Prob082_lfsr32 | 1 | timeout | - |
| Prob093_ece241_2014_q3 | 4 | pass | 4 |
| Prob099_m2014_q6c | 4 | compile_fail | - |
| Prob104_mt2015_muxdff | 1 | pass | 1 |
| Prob131_mt2015_q4 | 1 | pass | 1 |
| Prob133_2014_q3fsm | 1 | pass | 1 |
| Prob136_m2014_q6 | 1 | pass | 1 |
| Prob139_2013_q2bfsm | 1 | pass | 1 |
| Prob140_fsm_hdlc | 1 | pass | 1 |
| Prob141_count_clock | 4 | timeout | - |
| Prob146_fsm_serialdata | 1 | pass | 1 |
| Prob147_circuit10 | 1 | pass | 1 |
| Prob149_ece241_2013_q4 | 2 | pass | 2 |
| Prob151_review2015_fsm | 1 | pass | 1 |
| Prob154_fsm_ps2data | 2 | pass | 2 |
| Prob155_lemmings4 | 1 | pass | 1 |
| Prob156_review2015_fancytimer | 3 | timeout | - |

## Unrepaired Problems

Repository-evaluator accounting leaves these four problems unrepaired:

| Problem | First-pass status | Final repair status | Notes from logs |
| --- | --- | --- | --- |
| Prob082_lfsr32 | timeout | timeout | Simulation reached the run timeout with zero mismatches in 200000 samples. |
| Prob099_m2014_q6c | compile_fail | compile_fail | Icarus elaboration reported missing `Y2` and `Y4` ports in the black-box harness/reference path. |
| Prob141_count_clock | timeout | timeout | Later attempts reached timeout with zero mismatches in 200000 samples; attempt 01 introduced mismatches. |
| Prob156_review2015_fancytimer | timeout | timeout | Attempts had zero mismatches; attempt 02 finished at 999999 ps with 199999 samples, while the accounting summary still classifies the problem as timeout overall. |

## Caveat

The final result is 152 / 156 under the repository evaluator's timeout policy. `scripts/sv-iv-analyze` assigns pass only to result code `.`, and it assigns result code `T` as soon as a log contains `TIMEOUT`, before considering a later zero-mismatch line. The Makefile also records `TIMEOUT` when the outer simulator command times out. Under a separate "zero-mismatch timeout" interpretation, `Prob082_lfsr32` and `Prob141_count_clock` would need an explicit timeout-policy decision before being counted differently. `Prob156_review2015_fancytimer` also remains non-pass here because the zero-mismatch non-timeout attempt ended via `$finish` from the repair source before the harness finish point, so it is not treated as a normal benchmark pass.

## Artifact Checks

- Active `runs/verilog` contains 156 first-pass logs.
- Active `runs/verilog` contains no copied `*_test.sv` or `*_ref.sv` files.
- Active `runs/verilog` contains no `wave.vcd` files.
- Active `runs/verilog` contains 36 repaired Verilog attempt files.
