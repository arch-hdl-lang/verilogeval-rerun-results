//! ---
//! spec_md: dataset_spec-to-rtl/Prob107_fsm1s_prompt.txt
//! tags: [fsm, moore, synchronous-reset]
//! refs: []
//! ---
//!
//! Implements the VerilogEval Prob107_fsm1s two-state Moore machine.
//! Reset is active-high synchronous and returns the machine to state B.
/// Top-level two-state Moore FSM with the exact requested VerilogEval interface.
///
/// Port timing/type:
/// clk: input clock, sampled on the rising edge.
/// reset: active-high synchronous reset to state B.
/// in: one-bit input sampled by the FSM transition logic on the rising clock edge.
/// out: combinational state-derived Moore output visible from the current state.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | in == 0         | B             | A          | 1      |
/// | in == 1         | B             | B          | 1      |
/// | in == 0         | A             | B          | 0      |
/// | in == 1         | A             | A          | 0      |
module TopModule (
  input logic clk,
  input logic reset,
  input logic in,
  output logic out
);

  typedef enum logic [0:0] {
    A = 1'd0,
    B = 1'd1
  } TopModule_state_t;
  
  TopModule_state_t state_r, state_next;
  
  always_ff @(posedge clk) begin
    if (reset) begin
      state_r <= B;
    end else begin
      state_r <= state_next;
    end
  end
  
  always_comb begin
    state_next = state_r; // hold by default
    unique case (state_r)
      B: begin
        if (!in) state_next = A;
      end
      A: begin
        if (!in) state_next = B;
      end
      default: state_next = state_r;
    endcase
  end
  
  always_comb begin
    out = 1'b1;
    unique case (state_r)
      B: begin
      end
      A: begin
        out = 1'b0;
      end
      default: ;
    endcase
  end
  
  // synopsys translate_off
  _auto_reach_A: cover property (@(posedge clk) state_r == A);
  _auto_reach_B: cover property (@(posedge clk) state_r == B);
  _auto_tr_B_to_A: cover property (@(posedge clk) state_r == B && state_next == A);
  _auto_tr_A_to_B: cover property (@(posedge clk) state_r == A && state_next == B);
  // synopsys translate_on

endmodule

