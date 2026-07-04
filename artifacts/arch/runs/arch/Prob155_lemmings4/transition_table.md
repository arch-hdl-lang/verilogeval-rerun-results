# Prob155_lemmings4 Transition Table

Inputs are sampled on the positive edge of `clk`. `areset` is a positive-edge asynchronous reset to `WalkLeft`.
Outputs are Moore/state-derived combinational outputs: `walk_left`, `walk_right`, `aaah`, and `digging` reflect the current FSM state with no extra registered output latency.

| input condition | current state | next state | output |
| --- | --- | --- | --- |
| `ground == 0` | `WalkLeft` | `FallLeft` | `walk_left=1, walk_right=0, aaah=0, digging=0` |
| `ground == 1 and dig == 1` | `WalkLeft` | `DigLeft` | `walk_left=1, walk_right=0, aaah=0, digging=0` |
| `ground == 1 and dig == 0 and bump_left == 1` | `WalkLeft` | `WalkRight` | `walk_left=1, walk_right=0, aaah=0, digging=0` |
| otherwise | `WalkLeft` | `WalkLeft` | `walk_left=1, walk_right=0, aaah=0, digging=0` |
| `ground == 0` | `WalkRight` | `FallRight` | `walk_left=0, walk_right=1, aaah=0, digging=0` |
| `ground == 1 and dig == 1` | `WalkRight` | `DigRight` | `walk_left=0, walk_right=1, aaah=0, digging=0` |
| `ground == 1 and dig == 0 and bump_right == 1` | `WalkRight` | `WalkLeft` | `walk_left=0, walk_right=1, aaah=0, digging=0` |
| otherwise | `WalkRight` | `WalkRight` | `walk_left=0, walk_right=1, aaah=0, digging=0` |
| `ground == 0` | `DigLeft` | `FallLeft` | `walk_left=0, walk_right=0, aaah=0, digging=1` |
| otherwise | `DigLeft` | `DigLeft` | `walk_left=0, walk_right=0, aaah=0, digging=1` |
| `ground == 0` | `DigRight` | `FallRight` | `walk_left=0, walk_right=0, aaah=0, digging=1` |
| otherwise | `DigRight` | `DigRight` | `walk_left=0, walk_right=0, aaah=0, digging=1` |
| `ground == 1 and fall_ticks > 20` | `FallLeft` | `Splat` | `walk_left=0, walk_right=0, aaah=1, digging=0` |
| `ground == 1 and fall_ticks <= 20` | `FallLeft` | `WalkLeft` | `walk_left=0, walk_right=0, aaah=1, digging=0` |
| `ground == 0` | `FallLeft` | `FallLeft` | `walk_left=0, walk_right=0, aaah=1, digging=0` |
| `ground == 1 and fall_ticks > 20` | `FallRight` | `Splat` | `walk_left=0, walk_right=0, aaah=1, digging=0` |
| `ground == 1 and fall_ticks <= 20` | `FallRight` | `WalkRight` | `walk_left=0, walk_right=0, aaah=1, digging=0` |
| `ground == 0` | `FallRight` | `FallRight` | `walk_left=0, walk_right=0, aaah=1, digging=0` |
| any | `Splat` | `Splat` | `walk_left=0, walk_right=0, aaah=0, digging=0` |
