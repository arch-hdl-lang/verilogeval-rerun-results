//! ---
//! spec_md: dataset_spec-to-rtl/Prob066_edgecapture_prompt.txt
//! tags: [edge-capture, falling-edge, register, synchronous-reset]
//! refs: []
//! ---
//!
//! Implements a 32-bit falling-edge capture register. Each output bit latches high
//! after the corresponding input bit transitions from 1 to 0 and clears on reset.
/// Top-level falling-edge capture module for the VerilogEval interface.
///
/// `in` is sampled on the rising edge of `clk`; `out` is the sticky capture
/// register cleared by active-high synchronous reset. The edge expression is
/// evaluated directly in the clocked block to match clock-edge sampling races.
module TopModule (
  input logic clk,
  input logic reset,
  input logic [31:0] in,
  output logic [31:0] out
);

  logic [31:0] prev_in;
  always_ff @(posedge clk) begin
    prev_in <= in;
    if (reset) begin
      out <= 0;
    end else begin
      out <= out | (prev_in & ~in);
    end
  end

endmodule

