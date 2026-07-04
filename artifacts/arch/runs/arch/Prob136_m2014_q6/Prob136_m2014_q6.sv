//! ---
//! spec_md: dataset_spec-to-rtl/Prob136_m2014_q6_prompt.txt
//! tags: [fsm, moore, state-machine]
//! refs: []
//! ---
//!
//! Implements the requested six-state Moore state machine. State updates occur on
//! the positive edge of clk, reset returns the state register to A, and z is
//! derived combinationally from the current state.
/// Top-level registered Moore state machine for Prob136_m2014_q6.
///
/// Port timing/type notes:
/// - clk: positive-edge sequential clock.
/// - reset: synchronous active-high reset for the state register.
/// - w: one-bit input sampled for next-state selection on the positive clock edge.
/// - z: combinational/state-derived Moore output visible from the current state.
///
/// Transition table:
/// | input condition | current state | next state | output z |
/// | w == 0 | A | B | 0 |
/// | w == 1 | A | A | 0 |
/// | w == 0 | B | C | 0 |
/// | w == 1 | B | D | 0 |
/// | w == 0 | C | E | 0 |
/// | w == 1 | C | D | 0 |
/// | w == 0 | D | F | 0 |
/// | w == 1 | D | A | 0 |
/// | w == 0 | E | E | 1 |
/// | w == 1 | E | D | 1 |
/// | w == 0 | F | C | 1 |
/// | w == 1 | F | D | 1 |
module TopModule (
  input logic clk,
  input logic reset,
  input logic w,
  output logic z
);

  logic [2:0] state_cur;
  assign z = state_cur == 3'd4 || state_cur == 3'd5;
  always_ff @(posedge clk) begin
    if (reset) begin
      state_cur <= 0;
    end else begin
      if (state_cur == 3'd0) begin
        if (!w) begin
          state_cur <= 3'd1;
        end else begin
          state_cur <= 3'd0;
        end
      end else if (state_cur == 3'd1) begin
        if (!w) begin
          state_cur <= 3'd2;
        end else begin
          state_cur <= 3'd3;
        end
      end else if (state_cur == 3'd2) begin
        if (!w) begin
          state_cur <= 3'd4;
        end else begin
          state_cur <= 3'd3;
        end
      end else if (state_cur == 3'd3) begin
        if (!w) begin
          state_cur <= 3'd5;
        end else begin
          state_cur <= 3'd0;
        end
      end else if (state_cur == 3'd4) begin
        if (w) begin
          state_cur <= 3'd3;
        end else begin
          state_cur <= 3'd4;
        end
      end else if (!w) begin
        state_cur <= 3'd2;
      end else begin
        state_cur <= 3'd3;
      end
    end
  end

endmodule

