//! ---
//! spec_md: dataset_spec-to-rtl/Prob049_m2014_q4b_prompt.txt
//! tags: [dff, async_reset, sequential]
//! refs: []
//! ---
//!
//! Positive-edge-triggered D flip-flop with an active-high asynchronous reset.
/// Top-level D flip-flop requested by the VerilogEval prompt.
///
/// Samples `d` on the rising edge of `clk`; `ar` asynchronously resets `q` low.
module TopModule (
  input logic clk,
  input logic ar,
  input logic d,
  output logic q
);

  always_ff @(posedge clk or posedge ar) begin
    if (ar) begin
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule

