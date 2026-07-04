# Prob099_m2014_q6c Transition Table

Port timing/type:

- `y`: combinational input, current one-hot state, `y[0]=A` through `y[5]=F`.
- `w`: combinational input controlling transitions.
- `Y1`: combinational output for next `y[1]`, state B.
- `Y3`: combinational output for next `y[3]`, state D.

| input condition | current state | next state | output |
| --- | --- | --- | --- |
| `w = 0` | A | B | `Y1=1, Y3=0` |
| `w = 1` | A | A | `Y1=0, Y3=0` |
| `w = 0` | B | C | `Y1=0, Y3=0` |
| `w = 1` | B | D | `Y1=0, Y3=1` |
| `w = 0` | C | E | `Y1=0, Y3=0` |
| `w = 1` | C | D | `Y1=0, Y3=1` |
| `w = 0` | D | F | `Y1=0, Y3=0` |
| `w = 1` | D | A | `Y1=0, Y3=0` |
| `w = 0` | E | E | `Y1=0, Y3=0` |
| `w = 1` | E | D | `Y1=0, Y3=1` |
| `w = 0` | F | C | `Y1=0, Y3=0` |
| `w = 1` | F | D | `Y1=0, Y3=1` |
