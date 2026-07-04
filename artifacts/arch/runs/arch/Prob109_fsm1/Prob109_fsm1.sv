//! ---
//! spec_md: dataset_spec-to-rtl/Prob109_fsm1_prompt.txt
//! tags: [fsm, moore, async-reset]
//! ---
//!
//! Two-state Moore machine for Prob109_fsm1. The asynchronous active-high reset
//! returns the state machine to state B, where the state-derived output is high.
/// Top-level Moore FSM with the exact requested TopModule interface.
///
/// Timing/types:
/// input clk: positive-edge clock.
/// input areset: asynchronous active-high reset, resetting state to B.
/// input in: sampled on clk rising for state transitions.
/// output out: combinational/state-derived Moore output.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | in == 0         | B             | A          | 1      |
/// | in == 1         | B             | B          | 1      |
/// | in == 0         | A             | B          | 0      |
/// | in == 1         | A             | A          | 0      |
module TopModule (
  input logic clk,
  input logic areset,
  input logic in,
  output logic out
);

  typedef enum logic [0:0] {
    A = 1'd0,
    B = 1'd1
  } TopModule_state_t;
  
  TopModule_state_t state_r, state_next;
  
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      state_r <= B;
    end else begin
      state_r <= state_next;
    end
  end
  
  always_comb begin
    state_next = state_r; // hold by default
    unique case (state_r)
      A: begin
        if (!in) state_next = B;
      end
      B: begin
        if (!in) state_next = A;
      end
      default: state_next = state_r;
    endcase
  end
  
  always_comb begin
    out = 1'b0;
    unique case (state_r)
      A: begin
      end
      B: begin
        out = 1'b1;
      end
      default: ;
    endcase
  end
  
  // synopsys translate_off
  _auto_reach_A: cover property (@(posedge clk) state_r == A);
  _auto_reach_B: cover property (@(posedge clk) state_r == B);
  _auto_tr_A_to_B: cover property (@(posedge clk) state_r == A && state_next == B);
  _auto_tr_B_to_A: cover property (@(posedge clk) state_r == B && state_next == A);
  // synopsys translate_on

endmodule

