# Prob080_timer Timing and Transition Table

Port timing/type:

- `clk`: input clock, positive-edge sampled.
- `load`: one-bit input sampled on the positive edge of `clk`.
- `data`: 10-bit input sampled on the positive edge of `clk` when `load` is high.
- `tc`: combinational output derived from the current internal counter value; high when the counter is zero.

| Input condition | Current counter | Next counter | Output `tc` |
| --- | --- | --- | --- |
| `load == 1` | any value | `data` | current `counter == 0` before the edge; after the edge reflects `data == 0` |
| `load == 0 && counter != 0` | nonzero | `counter - 1` | `0` before the edge; after the edge reflects whether the decremented value is zero |
| `load == 0 && counter == 0` | zero | zero | `1` |
