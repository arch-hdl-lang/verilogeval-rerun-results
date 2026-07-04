//! ---
//! spec_md: dataset_spec-to-rtl/Prob046_dff8p_prompt.txt
//! tags: [dff, reset, negedge]
//! ---
//!
//! Implements an 8-bit bank of D flip-flops. The output samples `d` on each
//! falling edge of `clk`, with active-high synchronous reset to 8'h34.
/// Eight negative-edge-triggered D flip-flops with synchronous reset.
///
/// The top-level interface is the VerilogEval-requested TopModule port set.
module TopModule (
  input logic clk,
  input logic reset,
  input logic [7:0] d,
  output logic [7:0] q
);

  always_ff @(negedge clk) begin
    if (reset) begin
      q <= 8'd52;
    end else begin
      q <= d;
    end
  end

endmodule

