//! ---
//! spec_md: dataset_spec-to-rtl/Prob040_count10_prompt.txt
//! tags: [counter, decade, synchronous-reset]
//! refs: []
//! ---
//!
//! Implements the requested TopModule as a positive-edge decade counter.
//! The active-high synchronous reset returns the count output to zero.
/// Top-level decade counter with the exact VerilogEval interface.
///
/// `q` is a registered 4-bit output that advances 0 through 9 on each
/// rising clock edge and wraps back to 0 after 9.
module TopModule (
  input logic clk,
  input logic reset,
  output logic [3:0] q
);

  always_ff @(posedge clk) begin
    if (reset) begin
      q <= 0;
    end else begin
      if (q == 4'd9) begin
        q <= 4'd0;
      end else begin
        q <= 4'(q + 4'd1);
      end
    end
  end

endmodule

