//! ---
//! spec_md: dataset_spec-to-rtl/Prob119_fsm3_prompt.txt
//! tags: [fsm, moore, async-reset, state-machine]
//! refs: []
//! ---
//!
//! Four-state Moore FSM for Prob119_fsm3. The FSM samples `in` on the
//! positive clock edge, asynchronously resets high to state A, and asserts
//! `out` only while in state D.
/// Top-level Moore FSM with the exact requested VerilogEval interface.
///
/// Port timing/types:
/// input `clk`: positive-edge clock.
/// input `areset`: asynchronous active-high reset to state A.
/// input `in`: sampled on the positive edge of `clk`.
/// output `out`: combinational/state-derived Moore output with zero extra latency.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | in == 0         | A             | A          | 0      |
/// | in == 1         | A             | B          | 0      |
/// | in == 0         | B             | C          | 0      |
/// | in == 1         | B             | B          | 0      |
/// | in == 0         | C             | A          | 0      |
/// | in == 1         | C             | D          | 0      |
/// | in == 0         | D             | C          | 1      |
/// | in == 1         | D             | B          | 1      |
module TopModule (
  input logic clk,
  input logic areset,
  input logic in,
  output logic out
);

  typedef enum logic [1:0] {
    A = 2'd0,
    B = 2'd1,
    C = 2'd2,
    D = 2'd3
  } TopModule_state_t;
  
  TopModule_state_t state_r, state_next;
  
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      state_r <= A;
    end else begin
      state_r <= state_next;
    end
  end
  
  always_comb begin
    state_next = state_r; // hold by default
    unique case (state_r)
      A: begin
        if (in) state_next = B;
      end
      B: begin
        if (!in) state_next = C;
      end
      C: begin
        if (!in) state_next = A;
        else if (in) state_next = D;
      end
      D: begin
        if (!in) state_next = C;
        else if (in) state_next = B;
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
      end
      C: begin
      end
      D: begin
        out = 1'b1;
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
  _auto_tr_B_to_C: cover property (@(posedge clk) state_r == B && state_next == C);
  _auto_tr_C_to_A: cover property (@(posedge clk) state_r == C && state_next == A);
  _auto_tr_C_to_D: cover property (@(posedge clk) state_r == C && state_next == D);
  _auto_tr_D_to_C: cover property (@(posedge clk) state_r == D && state_next == C);
  _auto_tr_D_to_B: cover property (@(posedge clk) state_r == D && state_next == B);
  // synopsys translate_on

endmodule

