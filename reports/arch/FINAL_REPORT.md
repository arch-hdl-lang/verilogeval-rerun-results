# ARCH VerilogEval Run Report

## First Pass

- Total problems: 156
- Passed: 148
- Failed: 8
- Missing: 0
- Unknown: 0

## Repairs

- Total repair attempts: 14
- Passed repairs: 7
- Failed repairs: 7

## Final Effective Result

All recorded ARCH repair attempts:

- Final passed problems: 155 / 156
- Final unrepaired problems: 1 / 156
- Unrepaired problem: Prob099_m2014_q6c

Fair-comparison result using the direct-Verilog repair budget of at most 4
attempts per failed problem:

- Final passed problems: 154 / 156
- Final unrepaired problems: 2 / 156
- Unrepaired problems: Prob066_edgecapture, Prob099_m2014_q6c
- Prob066_edgecapture is counted as unrepaired in this view because attempts
  1-4 all failed with 4 mismatches in 266 samples; it only passed on attempt 7.

## Incomplete First-Pass Problems

- None

## Failed First-Pass Problems

- Prob053_m2014_q4d (1 mismatches in 100 samples)
- Prob062_bugs_mux2 (111 mismatches in 114 samples)
- Prob063_review2015_shiftcount (1886 mismatches in 2071 samples)
- Prob066_edgecapture (95 mismatches in 266 samples)
- Prob093_ece241_2014_q3 (11 mismatches in 60 samples)
- Prob099_m2014_q6c
- Prob104_mt2015_muxdff (1 mismatches in 199 samples)
- Prob149_ece241_2013_q4 (1171 mismatches in 2040 samples)

## Repair Attempts By Problem

- Prob053_m2014_q4d: 1
- Prob062_bugs_mux2: 1
- Prob063_review2015_shiftcount: 1
- Prob066_edgecapture: 7 (passed on attempt 7; counted as failure under the 4-attempt fair-comparison cap)
- Prob093_ece241_2014_q3: 1
- Prob099_m2014_q6c: 1
- Prob104_mt2015_muxdff: 1
- Prob149_ece241_2013_q4: 1

## Successful Repair Problems

- Prob053_m2014_q4d
- Prob062_bugs_mux2
- Prob063_review2015_shiftcount
- Prob066_edgecapture (repair_attempt_07, 0 mismatches in 266 samples; outside the 4-attempt fair-comparison cap)
- Prob093_ece241_2014_q3
- Prob104_mt2015_muxdff
- Prob149_ece241_2013_q4

## Failed Repair Attempts

- Prob066_edgecapture (4 mismatches in 266 samples) [/Users/shuqingzhao/github/verilog-eval-arch/runs/arch/Prob066_edgecapture/repair_attempt_01_result.json]
- Prob066_edgecapture (4 mismatches in 266 samples) [/Users/shuqingzhao/github/verilog-eval-arch/runs/arch/Prob066_edgecapture/repair_attempt_02_result.json]
- Prob066_edgecapture (4 mismatches in 266 samples) [/Users/shuqingzhao/github/verilog-eval-arch/runs/arch/Prob066_edgecapture/repair_attempt_03_result.json]
- Prob066_edgecapture (4 mismatches in 266 samples) [/Users/shuqingzhao/github/verilog-eval-arch/runs/arch/Prob066_edgecapture/repair_attempt_04_result.json]
- Prob066_edgecapture (95 mismatches in 266 samples) [/Users/shuqingzhao/github/verilog-eval-arch/runs/arch/Prob066_edgecapture/repair_attempt_05_result.json]
- Prob066_edgecapture (4 mismatches in 266 samples) [/Users/shuqingzhao/github/verilog-eval-arch/runs/arch/Prob066_edgecapture/repair_attempt_06_result.json]
- Prob099_m2014_q6c [/Users/shuqingzhao/github/verilog-eval-arch/runs/arch/Prob099_m2014_q6c/repair_attempt_01_result.json]
