//! ---
//! spec_md: dataset_spec-to-rtl/Prob047_dff8ar_prompt.txt
//! tags: [dff, async-reset, register-bank]
//! refs: []
//! ---
//!
//! Implements an 8-bit bank of positive-edge-triggered D flip-flops with
//! active-high asynchronous reset. The registered output resets to zero and
//! otherwise captures the 8-bit input on each rising clock edge.
/// Top-level 8-bit D flip-flop bank requested by Prob047_dff8ar.
///
/// The `q` output is a registered one-cycle-latency port with active-high
/// asynchronous reset to zero.
module TopModule (
  input logic clk,
  input logic areset,
  input logic [7:0] d,
  output logic [7:0] q
);

  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      q <= 0;
    end else begin
      q <= d;
    end
  end

endmodule

