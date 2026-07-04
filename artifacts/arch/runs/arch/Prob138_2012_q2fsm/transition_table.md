# Prob138_2012_q2fsm Transition Table

Input sampling and reset timing: `w` is sampled on the positive edge of `clk`; `reset` is synchronous active-high and returns the FSM to state `A`.

Output timing/type: `z` is a combinational, state-derived Moore output. It is visible as `1` in states `E` and `F`, and `0` in states `A`, `B`, `C`, and `D`.

| input condition | current state | next state | output `z` |
| --- | --- | --- | --- |
| `w == 0` | `A` | `A` | `0` |
| `w == 1` | `A` | `B` | `0` |
| `w == 0` | `B` | `D` | `0` |
| `w == 1` | `B` | `C` | `0` |
| `w == 0` | `C` | `D` | `0` |
| `w == 1` | `C` | `E` | `0` |
| `w == 0` | `D` | `A` | `0` |
| `w == 1` | `D` | `F` | `0` |
| `w == 0` | `E` | `D` | `1` |
| `w == 1` | `E` | `E` | `1` |
| `w == 0` | `F` | `D` | `1` |
| `w == 1` | `F` | `C` | `1` |
