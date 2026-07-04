//! ---
//! spec_md: dataset_spec-to-rtl/Prob100_fsm3comb_prompt.txt
//! tags: [fsm, combinational, moore, next-state]
//! refs: []
//! ---
//!
//! Combinational Moore FSM transition and output logic for the VerilogEval Prob100_fsm3comb prompt.
//! The current encoded state is supplied as an input, and this module computes next_state and out without internal storage.
/// TopModule implements the combinational portion of a four-state Moore FSM.
///
/// Port timing/type:
/// input in: combinational one-bit input used to choose the next state.
/// input state: combinational 2-bit encoded current state, with A=2'b00, B=2'b01, C=2'b10, D=2'b11.
/// output next_state: combinational 2-bit encoded next state.
/// output out: combinational Moore output derived from the current state.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | in=0 | A (2'b00) | A (2'b00) | 0 |
/// | in=1 | A (2'b00) | B (2'b01) | 0 |
/// | in=0 | B (2'b01) | C (2'b10) | 0 |
/// | in=1 | B (2'b01) | B (2'b01) | 0 |
/// | in=0 | C (2'b10) | A (2'b00) | 0 |
/// | in=1 | C (2'b10) | D (2'b11) | 0 |
/// | in=0 | D (2'b11) | C (2'b10) | 1 |
/// | in=1 | D (2'b11) | B (2'b01) | 1 |
module TopModule (
  input logic in,
  input logic [1:0] state,
  output logic [1:0] next_state,
  output logic out
);

  always_comb begin
    unique case (state)
      2'd0: begin
        next_state = in ? 2'd1 : 2'd0;
      end
      2'd1: begin
        next_state = in ? 2'd1 : 2'd2;
      end
      2'd2: begin
        next_state = in ? 2'd3 : 2'd0;
      end
      2'd3: begin
        next_state = in ? 2'd1 : 2'd2;
      end
    endcase
    out = state == 2'd3;
  end

endmodule

