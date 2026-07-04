//! ---
//! spec_md: dataset_spec-to-rtl/Prob037_review2015_count1k_prompt.txt
//! tags: [counter, modulo, synchronous-reset]
//! ---
//!
//! Implements a 10-bit synchronous modulo-1000 counter. The counter resets to 0 on an active-high synchronous reset and otherwise advances once per positive clock edge.
/// Top-level modulo-1000 counter for the VerilogEval problem interface.
///
/// The 10-bit output is registered state: it holds values 0 through 999, wraps to 0 after 999, and synchronously resets to 0.
module TopModule (
  input logic clk,
  input logic reset,
  output logic [9:0] q
);

  always_ff @(posedge clk) begin
    if (reset) begin
      q <= 0;
    end else begin
      if (q == 10'd999) begin
        q <= 10'd0;
      end else begin
        q <= 10'(q + 10'd1);
      end
    end
  end

endmodule

