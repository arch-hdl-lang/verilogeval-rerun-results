//! ---
//! spec_md: dataset_spec-to-rtl/Prob133_2014_q3fsm_prompt.txt
//! tags: [fsm, sequence-counting, synchronous-reset]
//! refs: []
//! ---
//!
//! Implements the requested TopModule finite state machine. The FSM waits in
//! state A until s is asserted, then evaluates w in repeating three-cycle
//! windows and drives z high only in the cycle following a window with exactly
//! two asserted samples.
/// Top-level FSM for Prob133_2014_q3fsm.
///
/// Port timing/type notes:
/// - clk: positive-edge clock.
/// - reset: active-high synchronous reset to state A.
/// - s: sampled on clk rising only while in state A.
/// - w: sampled on clk rising while checking repeating three-cycle windows.
/// - z: combinational, state-derived output visible for the current state.
///
/// Standard transition table:
/// | input condition | current state | next state | output z |
/// | s = 0 | A | A | 0 |
/// | s = 1 | A | B | 0 |
/// | w = 0 | B | C0 | 0 |
/// | w = 1 | B | C1 | 0 |
/// | w = 0 | G | C0 | 1 |
/// | w = 1 | G | C1 | 1 |
/// | w = 0 | C0 | D0 | 0 |
/// | w = 1 | C0 | D1 | 0 |
/// | w = 0 | C1 | D1 | 0 |
/// | w = 1 | C1 | D2 | 0 |
/// | w = 0 | D0 | B | 0 |
/// | w = 1 | D0 | B | 0 |
/// | w = 0 | D1 | B | 0 |
/// | w = 1 | D1 | G | 0 |
/// | w = 0 | D2 | G | 0 |
/// | w = 1 | D2 | B | 0 |
module TopModule (
  input logic clk,
  input logic reset,
  input logic s,
  input logic w,
  output logic z
);

  typedef enum logic [2:0] {
    A = 3'd0,
    B = 3'd1,
    C0 = 3'd2,
    C1 = 3'd3,
    D0 = 3'd4,
    D1 = 3'd5,
    D2 = 3'd6,
    G = 3'd7
  } TopModule_state_t;
  
  TopModule_state_t state_r, state_next;
  
  always_ff @(posedge clk) begin
    if (reset) begin
      state_r <= A;
    end else begin
      state_r <= state_next;
    end
  end
  
  always_comb begin
    state_next = state_r; // hold by default
    unique case (state_r)
      A: begin
        if (s) state_next = B;
      end
      B: begin
        if (w) state_next = C1;
        else if (!w) state_next = C0;
      end
      G: begin
        if (w) state_next = C1;
        else if (!w) state_next = C0;
      end
      C0: begin
        if (w) state_next = D1;
        else if (!w) state_next = D0;
      end
      C1: begin
        if (w) state_next = D2;
        else if (!w) state_next = D1;
      end
      D0: begin
        state_next = B;
      end
      D1: begin
        if (w) state_next = G;
        else if (!w) state_next = B;
      end
      D2: begin
        if (w) state_next = B;
        else if (!w) state_next = G;
      end
      default: state_next = state_r;
    endcase
  end
  
  always_comb begin
    z = 1'b0;
    unique case (state_r)
      A: begin
      end
      B: begin
      end
      G: begin
        z = 1'b1;
      end
      C0: begin
      end
      C1: begin
      end
      D0: begin
      end
      D1: begin
      end
      D2: begin
      end
      default: ;
    endcase
  end
  
  // synopsys translate_off
  _auto_reach_A: cover property (@(posedge clk) state_r == A);
  _auto_reach_B: cover property (@(posedge clk) state_r == B);
  _auto_reach_C0: cover property (@(posedge clk) state_r == C0);
  _auto_reach_C1: cover property (@(posedge clk) state_r == C1);
  _auto_reach_D0: cover property (@(posedge clk) state_r == D0);
  _auto_reach_D1: cover property (@(posedge clk) state_r == D1);
  _auto_reach_D2: cover property (@(posedge clk) state_r == D2);
  _auto_reach_G: cover property (@(posedge clk) state_r == G);
  _auto_tr_A_to_B: cover property (@(posedge clk) state_r == A && state_next == B);
  _auto_tr_B_to_C1: cover property (@(posedge clk) state_r == B && state_next == C1);
  _auto_tr_B_to_C0: cover property (@(posedge clk) state_r == B && state_next == C0);
  _auto_tr_G_to_C1: cover property (@(posedge clk) state_r == G && state_next == C1);
  _auto_tr_G_to_C0: cover property (@(posedge clk) state_r == G && state_next == C0);
  _auto_tr_C0_to_D1: cover property (@(posedge clk) state_r == C0 && state_next == D1);
  _auto_tr_C0_to_D0: cover property (@(posedge clk) state_r == C0 && state_next == D0);
  _auto_tr_C1_to_D2: cover property (@(posedge clk) state_r == C1 && state_next == D2);
  _auto_tr_C1_to_D1: cover property (@(posedge clk) state_r == C1 && state_next == D1);
  _auto_tr_D0_to_B: cover property (@(posedge clk) state_r == D0 && state_next == B);
  _auto_tr_D1_to_G: cover property (@(posedge clk) state_r == D1 && state_next == G);
  _auto_tr_D1_to_B: cover property (@(posedge clk) state_r == D1 && state_next == B);
  _auto_tr_D2_to_B: cover property (@(posedge clk) state_r == D2 && state_next == B);
  _auto_tr_D2_to_G: cover property (@(posedge clk) state_r == D2 && state_next == G);
  // synopsys translate_on

endmodule

