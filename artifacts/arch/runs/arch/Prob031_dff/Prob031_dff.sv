//! ---
//! spec_md: dataset_spec-to-rtl/Prob031_dff_prompt.txt
//! tags: [dff, sequential, register]
//! refs: []
//! ---
//!
//! Implements the Prob031_dff prompt as a single positive-edge D flip-flop.
//! The q port is the registered output that captures d on each rising edge of clk.
/// Single-bit positive-edge D flip-flop.
///
/// Captures d on each rising edge of clk and presents the sampled value on q
/// with one cycle of registered output latency.
module TopModule (
  input logic clk,
  input logic d,
  output logic q
);

  always_ff @(posedge clk) begin
    q <= d;
  end

endmodule

