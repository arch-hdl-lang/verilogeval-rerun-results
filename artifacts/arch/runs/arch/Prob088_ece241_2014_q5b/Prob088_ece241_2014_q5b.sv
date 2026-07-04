//! ---
//! spec_md: dataset_spec-to-rtl/Prob088_ece241_2014_q5b_prompt.txt
//! tags: [fsm, mealy, twos-complementer, async-reset, one-hot]
//! refs: []
//! ---
//!
//! Two-state Mealy 2's complementer from the VerilogEval prompt. The requested machine resets asynchronously active-high into state A and uses the conceptual one-hot state set A/B.
/// TopModule implements the requested Mealy finite-state machine.
///
/// Port timing/type notes:
/// - clk: positive-edge clock for sequential state updates.
/// - areset: asynchronous active-high reset; state resets to A.
/// - x: one-bit FSM input sampled by combinational Mealy output and next-state logic.
/// - z: one-bit combinational Mealy output, visible in the same cycle from current state and x.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | x = 0 | A | A | z = 0 |
/// | x = 1 | A | B | z = 1 |
/// | x = 0 | B | B | z = 1 |
/// | x = 1 | B | B | z = 0 |
module TopModule (
  input logic clk,
  input logic areset,
  input logic x,
  output logic z
);

  typedef enum logic [0:0] {
    A = 1'd0,
    B = 1'd1
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
        if (x) state_next = B;
      end
      B: begin
        if (x) state_next = B;
      end
      default: state_next = state_r;
    endcase
  end
  
  always_comb begin
    z = 1'b0;
    unique case (state_r)
      A: begin
        z = x;
      end
      B: begin
        z = !x;
      end
      default: ;
    endcase
  end
  
  // synopsys translate_off
  _auto_reach_A: cover property (@(posedge clk) state_r == A);
  _auto_reach_B: cover property (@(posedge clk) state_r == B);
  _auto_tr_A_to_B: cover property (@(posedge clk) state_r == A && state_next == B);
  _auto_tr_B_to_B: cover property (@(posedge clk) state_r == B && state_next == B);
  // synopsys translate_on

endmodule

