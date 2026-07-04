//! ---
//! spec_md: dataset_spec-to-rtl/Prob091_2012_q2b_prompt.txt
//! tags: [fsm, onehot, next-state, combinational]
//! refs: []
//! ---
//!
//! Combinational next-state output logic for selected flip-flop inputs of a
//! one-hot encoded six-state FSM.
/// Implements the requested TopModule interface for FSM state output logic.
///
/// Input `y[5:0]` is the current one-hot state encoding and `w` is the FSM
/// transition input. Outputs `Y1` and `Y3` are combinational next-state inputs
/// for state flip-flops `y[1]` and `y[3]`.
module TopModule (
  input logic [5:0] y,
  input logic w,
  output logic Y1,
  output logic Y3
);

  assign Y1 = y[0] && w;
  assign Y3 = !w && (y[1] || y[2] || y[4] || y[5]);

endmodule

