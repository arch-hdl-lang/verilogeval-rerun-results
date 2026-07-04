//! ---
//! spec_md: dataset_spec-to-rtl/Prob041_dff8r_prompt.txt
//! tags: [dff, register, reset, synchronous]
//! refs: []
//! ---
//!
//! Implements an 8-bit bank of positive-edge-triggered D flip-flops with
//! active-high synchronous reset to zero.
/// Top-level 8-bit D flip-flop register bank.
///
/// Captures `d` on each rising edge of `clk`; synchronous active-high `reset`
/// sets `q` to zero.
module TopModule (
  input logic clk,
  input logic reset,
  input logic [7:0] d,
  output logic [7:0] q
);

  always_ff @(posedge clk) begin
    if (reset) begin
      q <= 0;
    end else begin
      q <= d;
    end
  end

endmodule

