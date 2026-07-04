//! ---
//! spec_md: dataset_spec-to-rtl/Prob038_count15_prompt.txt
//! tags: [counter, synchronous-reset, modulo-16]
//! refs: []
//! ---
//!
//! Four-bit binary counter with a period of sixteen. The counter advances on
//! each positive clock edge and synchronously resets to zero when reset is high.
/// Top-level 4-bit modulo-16 counter required by Prob038_count15.
///
/// Port timing: clk is sampled on the rising edge; reset is active-high
/// synchronous; q is a registered 4-bit output that holds the counter state.
module TopModule (
  input logic clk,
  input logic reset,
  output logic [3:0] q
);

  always_ff @(posedge clk) begin
    if (reset) begin
      q <= 0;
    end else begin
      q <= ($bits(q) > 4 ? $bits(q) : 4)'(q + 4'd1);
    end
  end

endmodule

