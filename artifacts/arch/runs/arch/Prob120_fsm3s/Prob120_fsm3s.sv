//! ---
//! spec_md: dataset_spec-to-rtl/Prob120_fsm3s_prompt.txt
//! tags: [fsm, moore, sync-reset, verilogeval]
//! refs: []
//! ---
//!
//! Four-state Moore FSM for the VerilogEval Prob120_fsm3s prompt. The FSM has
//! synchronous active-high reset to state A and drives out high only in state D.
/// TopModule implements the requested four-state Moore state machine.
///
/// Timing/type notes:
/// - clk is the positive-edge sequential clock.
/// - reset is synchronous active-high and returns the FSM to A.
/// - in is sampled by the state transition logic on each rising clock edge.
/// - out is a combinational, state-derived Moore output with no pipe_reg latency.
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
  input logic reset,
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

