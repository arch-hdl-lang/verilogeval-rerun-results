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
/// `in` is sampled on the rising edge of `clk`; `out` is a registered capture
/// vector that holds detected 1-to-0 transitions until synchronous reset.
module TopModule (
  input logic clk,
  input logic reset,
  input logic [31:0] in,
  output logic [31:0] out
);

  logic [31:0] falling_edges;
  logic [31:0] next_capture;
  logic [31:0] prev_in;
  assign falling_edges = prev_in & ~in;
  assign next_capture = out | falling_edges;
  always_ff @(posedge clk) begin
    if (reset) begin
      out <= 0;
      prev_in <= 0;
    end else begin
      prev_in <= in;
      out <= next_capture;
    end
  end

endmodule

