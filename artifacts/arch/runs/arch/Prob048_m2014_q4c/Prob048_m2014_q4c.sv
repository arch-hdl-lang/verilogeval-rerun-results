//! ---
//! spec_md: dataset_spec-to-rtl/Prob048_m2014_q4c_prompt.txt
//! tags: [dff, synchronous_reset, sequential]
//! ---
//!
//! Implements the requested one-bit D flip-flop with active-high synchronous reset.
/// Top-level one-bit D flip-flop.
///
/// Samples d on the rising edge of clk and drives q low when the synchronous
/// active-high reset r is asserted.
module TopModule (
  input logic clk,
  input logic d,
  input logic r,
  output logic q
);

  always_ff @(posedge clk) begin
    if (r) begin
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule

