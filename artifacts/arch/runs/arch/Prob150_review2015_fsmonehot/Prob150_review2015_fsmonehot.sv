//! ---
//! spec_md: dataset_spec-to-rtl/Prob150_review2015_fsmonehot_prompt.txt
//! tags: [fsm, onehot, combinational, next_state, moore]
//! ---
//!
//! Combinational next-state and Moore-output decode for the Review 2015 one-hot FSM.
//! The state register is external; this module only derives requested next-state bits and outputs.
/// Top-level combinational one-hot FSM decoder.
///
/// Port timing/types:
/// input d, done_counting, ack: combinational inputs sampled by external state logic.
/// input state[9:0]: current one-hot state encoding, with state[0]=S through state[9]=Wait.
/// outputs B3_next, S_next, S1_next, Count_next, Wait_next: combinational next-state decode bits.
/// outputs done, counting, shift_ena: combinational Moore outputs from current state.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | d=0 | S | S | shift_ena=0, counting=0, done=0 |
/// | d=1 | S | S1 | shift_ena=0, counting=0, done=0 |
/// | d=0 | S1 | S | shift_ena=0, counting=0, done=0 |
/// | d=1 | S1 | S11 | shift_ena=0, counting=0, done=0 |
/// | d=0 | S11 | S110 | shift_ena=0, counting=0, done=0 |
/// | d=1 | S11 | S11 | shift_ena=0, counting=0, done=0 |
/// | d=0 | S110 | S | shift_ena=0, counting=0, done=0 |
/// | d=1 | S110 | B0 | shift_ena=0, counting=0, done=0 |
/// | always | B0 | B1 | shift_ena=1, counting=0, done=0 |
/// | always | B1 | B2 | shift_ena=1, counting=0, done=0 |
/// | always | B2 | B3 | shift_ena=1, counting=0, done=0 |
/// | always | B3 | Count | shift_ena=1, counting=0, done=0 |
/// | done_counting=0 | Count | Count | shift_ena=0, counting=1, done=0 |
/// | done_counting=1 | Count | Wait | shift_ena=0, counting=1, done=0 |
/// | ack=0 | Wait | Wait | shift_ena=0, counting=0, done=1 |
/// | ack=1 | Wait | S | shift_ena=0, counting=0, done=1 |
module TopModule (
  input logic d,
  input logic done_counting,
  input logic ack,
  input logic [9:0] state,
  output logic B3_next,
  output logic S_next,
  output logic S1_next,
  output logic Count_next,
  output logic Wait_next,
  output logic done,
  output logic counting,
  output logic shift_ena
);

  logic in_S;
  logic in_S1;
  logic in_S110;
  logic in_B0;
  logic in_B1;
  logic in_B2;
  logic in_B3;
  logic in_Count;
  logic in_Wait;
  assign in_S = state[0];
  assign in_S1 = state[1];
  assign in_S110 = state[3];
  assign in_B0 = state[4];
  assign in_B1 = state[5];
  assign in_B2 = state[6];
  assign in_B3 = state[7];
  assign in_Count = state[8];
  assign in_Wait = state[9];
  assign B3_next = in_B2;
  assign S_next = in_S && !d || in_S1 && !d || in_S110 && !d || in_Wait && ack;
  assign S1_next = in_S && d;
  assign Count_next = in_B3 || in_Count && !done_counting;
  assign Wait_next = in_Count && done_counting || in_Wait && !ack;
  assign done = in_Wait;
  assign counting = in_Count;
  assign shift_ena = in_B0 || in_B1 || in_B2 || in_B3;

endmodule

