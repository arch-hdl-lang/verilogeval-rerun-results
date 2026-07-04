//! ---
//! spec_md: dataset_spec-to-rtl/Prob143_fsm_onehot_prompt.txt
//! tags: [fsm, onehot, combinational, transition-logic]
//! refs: []
//! ---
//!
//! Implements the combinational transition and output logic for the Prob143
//! one-hot FSM prompt. The current state vector may contain multiple active
//! states, so each next-state and output bit is the OR of all active source
//! states that contribute to it.
/// TopModule implements the requested one-hot FSM next-state and output logic.
///
/// Port timing/type notes:
/// - `in`: combinational one-bit input; no clock sampling occurs in this module.
/// - `state`: combinational 10-bit current-state vector, with state[i] mapping to Si.
/// - `next_state`: combinational 10-bit next-state vector, with next_state[i] mapping to Si.
/// - `out1`, `out2`: combinational state-derived outputs, ORed across active state bits.
///
/// Transition table:
/// | input condition | current state | next state | output (out1, out2) |
/// | in == 0 | S0 | S0 | (0, 0) |
/// | in == 1 | S0 | S1 | (0, 0) |
/// | in == 0 | S1 | S0 | (0, 0) |
/// | in == 1 | S1 | S2 | (0, 0) |
/// | in == 0 | S2 | S0 | (0, 0) |
/// | in == 1 | S2 | S3 | (0, 0) |
/// | in == 0 | S3 | S0 | (0, 0) |
/// | in == 1 | S3 | S4 | (0, 0) |
/// | in == 0 | S4 | S0 | (0, 0) |
/// | in == 1 | S4 | S5 | (0, 0) |
/// | in == 0 | S5 | S8 | (0, 0) |
/// | in == 1 | S5 | S6 | (0, 0) |
/// | in == 0 | S6 | S9 | (0, 0) |
/// | in == 1 | S6 | S7 | (0, 0) |
/// | in == 0 | S7 | S0 | (0, 1) |
/// | in == 1 | S7 | S7 | (0, 1) |
/// | in == 0 | S8 | S0 | (1, 0) |
/// | in == 1 | S8 | S1 | (1, 0) |
/// | in == 0 | S9 | S0 | (1, 1) |
/// | in == 1 | S9 | S1 | (1, 1) |
module TopModule (
  input logic in,
  input logic [9:0] state,
  output logic [9:0] next_state,
  output logic out1,
  output logic out2
);

  logic input_zero;
  logic input_one;
  logic s0;
  logic s1;
  logic s2;
  logic s3;
  logic s4;
  logic s5;
  logic s6;
  logic s7;
  logic s8;
  logic s9;
  logic ns0;
  logic ns1;
  logic ns2;
  logic ns3;
  logic ns4;
  logic ns5;
  logic ns6;
  logic ns7;
  logic ns8;
  logic ns9;
  assign input_zero = in == 1'b0;
  assign input_one = in == 1'b1;
  assign s0 = state[0];
  assign s1 = state[1];
  assign s2 = state[2];
  assign s3 = state[3];
  assign s4 = state[4];
  assign s5 = state[5];
  assign s6 = state[6];
  assign s7 = state[7];
  assign s8 = state[8];
  assign s9 = state[9];
  assign ns0 = input_zero && (s0 || s1 || s2 || s3 || s4 || s7 || s8 || s9);
  assign ns1 = input_one && (s0 || s8 || s9);
  assign ns2 = input_one && s1;
  assign ns3 = input_one && s2;
  assign ns4 = input_one && s3;
  assign ns5 = input_one && s4;
  assign ns6 = input_one && s5;
  assign ns7 = input_one && (s6 || s7);
  assign ns8 = input_zero && s5;
  assign ns9 = input_zero && s6;
  assign next_state = {ns9, ns8, ns7, ns6, ns5, ns4, ns3, ns2, ns1, ns0};
  assign out1 = s8 || s9;
  assign out2 = s7 || s9;

endmodule

