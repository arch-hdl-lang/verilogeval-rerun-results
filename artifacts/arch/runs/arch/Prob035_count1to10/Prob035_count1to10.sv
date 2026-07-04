//! ---
//! spec_md: dataset_spec-to-rtl/Prob035_count1to10_prompt.txt
//! tags: [counter, decade, synchronous-reset]
//! refs: []
//! ---
//!
//! Implements the requested TopModule decade counter. The output q is the counter state and advances on each positive clock edge from 1 through 10, then wraps to 1.
/// Top-level decade counter matching the requested VerilogEval interface.
///
/// The synchronous active-high reset initializes q to 1; otherwise q advances through 1..10 inclusive on rising clock edges.
module TopModule (
  input logic clk,
  input logic reset,
  output logic [3:0] q
);

  always_ff @(posedge clk) begin
    if (reset) begin
      q <= 4'd1;
    end else begin
      if (q == 4'd10) begin
        q <= 4'd1;
      end else begin
        q <= ($bits(q) > 4 ? $bits(q) : 4)'(q + 4'd1);
      end
    end
  end

endmodule

