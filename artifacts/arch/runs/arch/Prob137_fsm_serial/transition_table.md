# Prob137_fsm_serial transition table

Input timing: `in` is sampled on the rising edge of `clk`. `reset` is active-high synchronous.

Output timing: `done` is a combinational/state-derived Moore output. It is high only in `Done`, the cycle after a valid stop bit was sampled.

| input condition | current state | next state | output |
| --- | --- | --- | --- |
| `in == 1` | `Idle` | `Idle` | `done = 0` |
| `in == 0` start bit | `Idle` | `Data0` | `done = 0` |
| any data bit 0 | `Data0` | `Data1` | `done = 0` |
| any data bit 1 | `Data1` | `Data2` | `done = 0` |
| any data bit 2 | `Data2` | `Data3` | `done = 0` |
| any data bit 3 | `Data3` | `Data4` | `done = 0` |
| any data bit 4 | `Data4` | `Data5` | `done = 0` |
| any data bit 5 | `Data5` | `Data6` | `done = 0` |
| any data bit 6 | `Data6` | `Data7` | `done = 0` |
| any data bit 7 | `Data7` | `Stop` | `done = 0` |
| `in == 1` valid stop bit | `Stop` | `Done` | `done = 0` |
| `in == 0` invalid stop bit | `Stop` | `WaitStop` | `done = 0` |
| `in == 0` still missing stop | `WaitStop` | `WaitStop` | `done = 0` |
| `in == 1` recovery stop found | `WaitStop` | `Idle` | `done = 0` |
| `in == 1` idle after byte | `Done` | `Idle` | `done = 1` |
| `in == 0` immediate next start bit | `Done` | `Data0` | `done = 1` |
