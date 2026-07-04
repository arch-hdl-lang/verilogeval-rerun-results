//! ---
//! spec_md: dataset_spec-to-rtl/Prob067_countslow_prompt.txt
//! tags: [counter, decade, synchronous-reset, enable]
//! refs: []
//! ---
//!
//! Implements the requested TopModule decade counter. The counter advances from 0 through 9 only when slowena is high and synchronously resets to 0 on active-high reset.
/// Top-level decade counter for Prob067_countslow.
///
/// The 4-bit q output reflects the current registered count. On each positive clock edge, reset takes the count to 0; otherwise slowena increments the count with wrap from 9 to 0.
module TopModule (
  input logic clk,
  input logic reset,
  input logic slowena,
  output logic [3:0] q
);

  logic [3:0] count_r;
  assign q = count_r;
  always_ff @(posedge clk) begin
    if (reset) begin
      count_r <= 0;
    end else begin
      if (slowena) begin
        if (count_r == 4'd9) begin
          count_r <= 0;
        end else begin
          count_r <= 4'(count_r + 4'd1);
        end
      end
    end
  end

endmodule

