# Prob088_ece241_2014_q5b Transition Table

Port timing/type notes:
- `clk`: positive-edge clock for sequential state updates.
- `areset`: asynchronous active-high reset; state resets to A.
- `x`: one-bit FSM input sampled by combinational Mealy output and next-state logic.
- `z`: one-bit combinational Mealy output, visible in the same cycle from current state and `x`.

| input condition | current state | next state | output |
| --- | --- | --- | --- |
| x = 0 | A | A | z = 0 |
| x = 1 | A | B | z = 1 |
| x = 0 | B | B | z = 1 |
| x = 1 | B | B | z = 0 |
