# Comparison

## Fair-Comparison Result

The fair comparison caps each failed problem at the same repair budget used in
the direct-Verilog run: at most 4 repair attempts per failed problem.

| Metric | Direct Verilog | ARCH HDL |
| --- | ---: | ---: |
| Total problems | 156 | 156 |
| First-pass passed | 133 | 148 |
| First-pass failed | 23 | 8 |
| Repaired within max-4 budget | 19 | 6 |
| Final passed within max-4 budget | 152 | 154 |
| Final unrepaired within max-4 budget | 4 | 2 |

## Notes

- ARCH HDL has a substantially stronger first pass: 148 passed vs 133 for
  direct Verilog.
- ARCH HDL remains ahead under the fair max-4 repair budget: 154 passed vs 152.
- `Prob066_edgecapture` is counted as an ARCH failure in the fair-comparison
  result because attempts 1-4 failed; it later passed on attempt 7.
- `Prob099_m2014_q6c` remains unrepaired in both lanes and appears to involve a
  benchmark harness/interface inconsistency rather than an ordinary RTL fix.

## All-Recorded ARCH View

If all recorded ARCH repair attempts are counted, ARCH reaches 155 / 156. This
view is useful as diagnostic evidence, but it is not the fair headline result
because it uses more repair attempts on `Prob066_edgecapture` than the
direct-Verilog run allowed.

