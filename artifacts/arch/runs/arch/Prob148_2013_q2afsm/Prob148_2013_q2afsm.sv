//! ---
//! spec_md: dataset_spec-to-rtl/Prob148_2013_q2afsm_prompt.txt
//! tags: [fsm, arbiter, priority, synchronous-reset]
//! refs: []
//! ---
//!
//! Priority arbiter FSM for three requesters. The active-low synchronous reset
//! returns the machine to the idle A state, and grants are state-derived.
/// Three-request priority arbiter FSM with state-derived grant outputs.
///
/// Port timing/types:
/// input clk: positive-edge sampling clock.
/// input resetn: active-low synchronous reset sampled on clk rising.
/// input r[2:0]: request vector sampled by FSM transition logic.
/// output g[2:0]: combinational/state-derived grant vector visible for the current state.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | r[0] == 0 and r[1] == 0 and r[2] == 0 | A | A | 3'b000 |
/// | r[0] == 1 | A | B | 3'b000 |
/// | r[0] == 0 and r[1] == 1 | A | C | 3'b000 |
/// | r[0] == 0 and r[1] == 0 and r[2] == 1 | A | D | 3'b000 |
/// | r[0] == 1 | B | B | 3'b001 |
/// | r[0] == 0 | B | A | 3'b001 |
/// | r[1] == 1 | C | C | 3'b010 |
/// | r[1] == 0 | C | A | 3'b010 |
/// | r[2] == 1 | D | D | 3'b100 |
/// | r[2] == 0 | D | A | 3'b100 |
module TopModule (
  input logic clk,
  input logic resetn,
  input logic [2:0] r,
  output logic [2:0] g
);

  typedef enum logic [1:0] {
    A = 2'd0,
    B = 2'd1,
    C = 2'd2,
    D = 2'd3
  } TopModule_state_t;
  
  TopModule_state_t state_r, state_next;
  
  always_ff @(posedge clk) begin
    if ((!resetn)) begin
      state_r <= A;
    end else begin
      state_r <= state_next;
    end
  end
  
  always_comb begin
    state_next = state_r; // hold by default
    unique case (state_r)
      A: begin
        if (r[0]) state_next = B;
        else if (!r[0] && r[1]) state_next = C;
        else if (!r[0] && !r[1] && r[2]) state_next = D;
      end
      B: begin
        if (!r[0]) state_next = A;
      end
      C: begin
        if (!r[1]) state_next = A;
      end
      D: begin
        if (!r[2]) state_next = A;
      end
      default: state_next = state_r;
    endcase
  end
  
  always_comb begin
    g = 3'd0;
    unique case (state_r)
      A: begin
      end
      B: begin
        g = 3'd1;
      end
      C: begin
        g = 3'd2;
      end
      D: begin
        g = 3'd4;
      end
      default: ;
    endcase
  end
  
  // synopsys translate_off
  _auto_reach_A: cover property (@(posedge clk) state_r == A);
  _auto_reach_B: cover property (@(posedge clk) state_r == B);
  _auto_reach_C: cover property (@(posedge clk) state_r == C);
  _auto_reach_D: cover property (@(posedge clk) state_r == D);
  _auto_tr_A_to_B: cover property (@(posedge clk) state_r == A && state_next == B);
  _auto_tr_A_to_C: cover property (@(posedge clk) state_r == A && state_next == C);
  _auto_tr_A_to_D: cover property (@(posedge clk) state_r == A && state_next == D);
  _auto_tr_B_to_A: cover property (@(posedge clk) state_r == B && state_next == A);
  _auto_tr_C_to_A: cover property (@(posedge clk) state_r == C && state_next == A);
  _auto_tr_D_to_A: cover property (@(posedge clk) state_r == D && state_next == A);
  // synopsys translate_on

endmodule

