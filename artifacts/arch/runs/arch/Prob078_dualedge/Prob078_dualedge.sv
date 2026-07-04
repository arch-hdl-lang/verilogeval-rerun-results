//! ---
//! spec_md: dataset_spec-to-rtl/Prob078_dualedge_prompt.txt
//! tags: [dualedge, flipflop, clocking]
//! ---
//!
//! Implements a one-bit dual-edge triggered flip-flop behavior using two
//! single-edge registers and a clock-level output mux.
/// Top-level dual-edge flip-flop emulation with the requested interface.
///
/// The rising-edge register holds the sample visible while clk is high, and
/// the falling-edge register holds the sample visible while clk is low.
module TopModule (
  input logic clk,
  input logic d,
  output logic q
);

  logic pos_sample;
  logic neg_sample;
  assign q = clk ? pos_sample : neg_sample;
  always_ff @(posedge clk) begin
    pos_sample <= d;
  end
  always_ff @(negedge clk) begin
    neg_sample <= d;
  end

endmodule

