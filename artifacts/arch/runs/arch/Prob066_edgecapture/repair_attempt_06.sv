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
/// `in` is sampled on the rising edge of `clk`; `out` reflects a sticky capture
/// register that clears on active-high synchronous reset while the previous
/// input sample continues tracking across reset cycles.
module TopModule (
  input logic clk,
  input logic reset,
  input logic [31:0] in,
  output logic [31:0] out
);

  logic [31:0] falling_edges;
  logic [31:0] held_capture;
  logic [31:0] prev_in;
  logic [31:0] capture;
  assign falling_edges = prev_in & ~in;
  assign held_capture = capture | falling_edges;
  assign out = capture;
  always_ff @(posedge clk) begin
    prev_in <= in;
    if (reset) begin
      capture <= 0;
    end else begin
      capture <= held_capture;
    end
  end

endmodule

