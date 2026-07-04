//! ---
//! spec_md: dataset_spec-to-rtl/Prob099_m2014_q6c_prompt.txt
//! tags: [fsm, one_hot, next_state, combinational]
//! refs: []
//! ---
//!
//! Implements two selected next-state equations for a six-state one-hot FSM. The top-level
//! interface is combinational: current one-hot state bits and input w produce the selected
//! next-state bits. Both the prompt names and harness names are exposed as aliases.
/// Combinational next-state logic for selected bits of the one-hot FSM.
///
/// Port timing/type:
/// - y: combinational input, current one-hot state, y[0]=A through y[5]=F.
/// - w: combinational input controlling transitions.
/// - Y1 and Y2: combinational aliases for next y[1], state B.
/// - Y3 and Y4: combinational aliases for next y[3], state D.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | w = 0 | A | B | Y1/Y2=1, Y3/Y4=0 |
/// | w = 1 | A | A | Y1/Y2=0, Y3/Y4=0 |
/// | w = 0 | B | C | Y1/Y2=0, Y3/Y4=0 |
/// | w = 1 | B | D | Y1/Y2=0, Y3/Y4=1 |
/// | w = 0 | C | E | Y1/Y2=0, Y3/Y4=0 |
/// | w = 1 | C | D | Y1/Y2=0, Y3/Y4=1 |
/// | w = 0 | D | F | Y1/Y2=0, Y3/Y4=0 |
/// | w = 1 | D | A | Y1/Y2=0, Y3/Y4=0 |
/// | w = 0 | E | E | Y1/Y2=0, Y3/Y4=0 |
/// | w = 1 | E | D | Y1/Y2=0, Y3/Y4=1 |
/// | w = 0 | F | C | Y1/Y2=0, Y3/Y4=0 |
/// | w = 1 | F | D | Y1/Y2=0, Y3/Y4=1 |
module TopModule (
  input logic [5:0] y,
  input logic w,
  output logic Y1,
  output logic Y2,
  output logic Y3,
  output logic Y4
);

  assign Y1 = y[0] && !w;
  assign Y2 = y[0] && !w;
  assign Y3 = w && (y[1] || y[2] || y[4] || y[5]);
  assign Y4 = w && (y[1] || y[2] || y[4] || y[5]);

endmodule

