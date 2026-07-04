//! ---
//! spec_md: dataset_spec-to-rtl/Prob034_dff8_prompt.txt
//! tags: [dff, register, sequential]
//! ---
//!
//! Implements TopModule as an 8-bit bank of positive-edge-triggered D flip-flops with no reset.
/// Top-level 8-bit D flip-flop bank.
///
/// Samples d on each rising clk edge and exposes the stored value on q.
module TopModule (
  input logic clk,
  input logic [7:0] d,
  output logic [7:0] q
);

  logic [7:0] q_r = 0;
  assign q = q_r;
  always_ff @(posedge clk) begin
    q_r <= d;
  end

endmodule

