//! ---
//! spec_md: dataset_spec-to-rtl/Prob138_2012_q2fsm_prompt.txt
//! tags: [fsm, moore, synchronous-reset]
//! refs: []
//! ---
//!
//! Implements the Prob138_2012_q2fsm six-state Moore FSM. The `z` output is
//! state-derived and high only in states E and F.
/// Top-level six-state Moore FSM for Prob138_2012_q2fsm.
///
/// Timing: `w` is sampled on the positive edge of `clk`; `reset` is
/// synchronous active-high and returns the FSM to A. `z` is a combinational,
/// state-derived output.
///
/// | input condition | current state | next state | output z |
/// | --- | --- | --- | --- |
/// | w == 0 | A | A | 0 |
/// | w == 1 | A | B | 0 |
/// | w == 0 | B | D | 0 |
/// | w == 1 | B | C | 0 |
/// | w == 0 | C | D | 0 |
/// | w == 1 | C | E | 0 |
/// | w == 0 | D | A | 0 |
/// | w == 1 | D | F | 0 |
/// | w == 0 | E | D | 1 |
/// | w == 1 | E | E | 1 |
/// | w == 0 | F | D | 1 |
/// | w == 1 | F | C | 1 |
module TopModule (
  input logic clk,
  input logic reset,
  input logic w,
  output logic z
);

  logic [2:0] state_r;
  logic [2:0] state_next;
  always_comb begin
    case (state_r)
      3'd0: begin
        state_next = w ? 3'd1 : 3'd0;
      end
      3'd1: begin
        state_next = w ? 3'd2 : 3'd3;
      end
      3'd2: begin
        state_next = w ? 3'd4 : 3'd3;
      end
      3'd3: begin
        state_next = w ? 3'd5 : 3'd0;
      end
      3'd4: begin
        state_next = w ? 3'd4 : 3'd3;
      end
      3'd5: begin
        state_next = w ? 3'd2 : 3'd3;
      end
      default: begin
        state_next = 3'd0;
      end
    endcase
    z = state_r == 3'd4 || state_r == 3'd5;
  end
  always_ff @(posedge clk) begin
    if (reset) begin
      state_r <= 0;
    end else begin
      state_r <= state_next;
    end
  end

endmodule

