# Prob156 Review2015 Fancy Timer Transition Table

Input timing/type:
- `clk`: positive-edge clock.
- `reset`: active-high synchronous reset to `Search0`.
- `data`: sampled on the rising edge while searching and reading delay bits.
- `ack`: sampled on the rising edge in `Done`.

Output timing/type:
- `count`: combinational/state-derived remaining thousand-count bucket.
- `counting`: combinational/state-derived, asserted only in `Count`.
- `done`: combinational/state-derived, asserted only in `Done`.

| input condition | current state | next state | output |
| --- | --- | --- | --- |
| `data == 1` | `Search0` | `Search1` | `counting=0`, `done=0`, `count=don't-care` |
| `data == 0` | `Search0` | `Search0` | `counting=0`, `done=0`, `count=don't-care` |
| `data == 1` | `Search1` | `Search2` | `counting=0`, `done=0`, `count=don't-care` |
| `data == 0` | `Search1` | `Search0` | `counting=0`, `done=0`, `count=don't-care` |
| `data == 0` | `Search2` | `Search3` | `counting=0`, `done=0`, `count=don't-care` |
| `data == 1` | `Search2` | `Search2` | `counting=0`, `done=0`, `count=don't-care` |
| `data == 1` | `Search3` | `Read3` | `counting=0`, `done=0`, `count=don't-care` |
| `data == 0` | `Search3` | `Search0` | `counting=0`, `done=0`, `count=don't-care` |
| any `data` | `Read3` | `Read2` | captures `delay[3]`, `counting=0`, `done=0` |
| any `data` | `Read2` | `Read1` | captures `delay[2]`, `counting=0`, `done=0` |
| any `data` | `Read1` | `Read0` | captures `delay[1]`, `counting=0`, `done=0` |
| any `data` | `Read0` | `Count` | captures `delay[0]`, loads 999-cycle bucket, `counting` visible next cycle |
| bucket not expired | `Count` | `Count` | `counting=1`, `done=0`, `count=remaining delay bucket` |
| bucket expired and `count != 0` | `Count` | `Count` | decrements visible count bucket, reloads 999 cycles |
| bucket expired and `count == 0` | `Count` | `Done` | final zero bucket complete; `done` visible next cycle |
| `ack == 0` | `Done` | `Done` | `counting=0`, `done=1`, `count=don't-care` |
| `ack == 1` | `Done` | `Search0` | `counting=0`, `done=1` until next clock edge |
