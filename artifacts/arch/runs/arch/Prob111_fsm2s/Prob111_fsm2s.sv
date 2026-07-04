//! ---
//! spec_md: dataset_spec-to-rtl/Prob111_fsm2s_prompt.txt
//! tags: [fsm, moore, two_state]
//! refs: []
//! ---
//!
//! Moore two-state FSM for Prob111_fsm2s. Reset is active-high synchronous to OFF, and out is derived directly from the current state.
/// Top-level two-state Moore FSM with exact VerilogEval interface.
///
/// Port timing/types:
/// - clk: positive-edge clock input.
/// - reset: active-high synchronous reset input sampled on clk.
/// - j, k: one-bit FSM inputs sampled on clk.
/// - out: combinational/state-derived Moore output, visible from the current state with no pipe_reg latency.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | j == 0          | OFF           | OFF        | 0      |
/// | j == 1          | OFF           | ON         | 0      |
/// | k == 0          | ON            | ON         | 1      |
/// | k == 1          | ON            | OFF        | 1      |
module TopModule (
  input logic clk,
  input logic reset,
  input logic j,
  input logic k,
  output logic out
);

  typedef enum logic [0:0] {
    OFF = 1'd0,
    ON = 1'd1
  } TopModule_state_t;
  
  TopModule_state_t state_r, state_next;
  
  always_ff @(posedge clk) begin
    if (reset) begin
      state_r <= OFF;
    end else begin
      state_r <= state_next;
    end
  end
  
  always_comb begin
    state_next = state_r; // hold by default
    unique case (state_r)
      OFF: begin
        if (j) state_next = ON;
      end
      ON: begin
        if (k) state_next = OFF;
      end
      default: state_next = state_r;
    endcase
  end
  
  always_comb begin
    out = 1'b0;
    unique case (state_r)
      OFF: begin
      end
      ON: begin
        out = 1'b1;
      end
      default: ;
    endcase
  end
  
  // synopsys translate_off
  _auto_reach_OFF: cover property (@(posedge clk) state_r == OFF);
  _auto_reach_ON: cover property (@(posedge clk) state_r == ON);
  _auto_tr_OFF_to_ON: cover property (@(posedge clk) state_r == OFF && state_next == ON);
  _auto_tr_ON_to_OFF: cover property (@(posedge clk) state_r == ON && state_next == OFF);
  // synopsys translate_on

endmodule

