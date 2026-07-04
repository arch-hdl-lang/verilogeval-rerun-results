//! ---
//! spec_md: dataset_spec-to-rtl/Prob060_m2014_q4k_prompt.txt
//! tags: [shift-register, d-flop, synchronous-reset]
//! refs: []
//! ---
//!
//! Implements the requested TopModule as a four-stage one-bit shift register.
//! All sequential logic samples on the rising edge of clk and resets synchronously when resetn is low.
/// Top-level four D-flop shift register with active-low synchronous reset.
///
/// The output reflects the current value held in the fourth register stage.
module TopModule (
  input logic clk,
  input logic resetn,
  input logic in,
  output logic out
);

  logic q0;
  logic q1;
  logic q2;
  logic q3;
  assign out = q3;
  always_ff @(posedge clk) begin
    if ((!resetn)) begin
      q0 <= 0;
      q1 <= 0;
      q2 <= 0;
      q3 <= 0;
    end else begin
      q0 <= in;
      q1 <= q0;
      q2 <= q1;
      q3 <= q2;
    end
  end

endmodule

