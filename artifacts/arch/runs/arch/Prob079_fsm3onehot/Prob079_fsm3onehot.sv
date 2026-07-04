//! ---
//! spec_md: dataset_spec-to-rtl/Prob079_fsm3onehot_prompt.txt
//! tags: [fsm, onehot, combinational, moore]
//! ---
//!
//! Combinational next-state and output logic for a four-state Moore machine.
//! The external state vector uses one-hot encoding A=0001, B=0010, C=0100,
//! D=1000 and no state register is implemented in this module.
/// TopModule implements the requested one-hot FSM transition and output logic.
///
/// Port timing/type:
/// - in: combinational one-bit input, not clock sampled by this module.
/// - state: combinational four-bit one-hot current-state input.
/// - next_state: combinational four-bit one-hot next-state output.
/// - out: combinational Moore output derived from the current state.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// |-----------------|---------------|------------|--------|
/// | in == 0         | A             | A          | 0      |
/// | in == 1         | A             | B          | 0      |
/// | in == 0         | B             | C          | 0      |
/// | in == 1         | B             | B          | 0      |
/// | in == 0         | C             | A          | 0      |
/// | in == 1         | C             | D          | 0      |
/// | in == 0         | D             | C          | 1      |
/// | in == 1         | D             | B          | 1      |
module TopModule (
  input logic in,
  input logic [3:0] state,
  output logic [3:0] next_state,
  output logic out
);

  logic state_a;
  logic state_b;
  logic state_c;
  logic state_d;
  logic next_a;
  logic next_b;
  logic next_c;
  logic next_d;
  assign state_a = state[0];
  assign state_b = state[1];
  assign state_c = state[2];
  assign state_d = state[3];
  assign next_a = !in && (state_a || state_c);
  assign next_b = in && (state_a || state_b || state_d);
  assign next_c = !in && (state_b || state_d);
  assign next_d = in && state_c;
  assign next_state = {next_d, next_c, next_b, next_a};
  assign out = state_d;

endmodule

