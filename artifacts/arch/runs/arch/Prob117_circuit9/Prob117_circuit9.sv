//! ---
//! spec_md: dataset_spec-to-rtl/Prob117_circuit9_prompt.txt
//! tags: [sequential, waveform, counter, modulo, registered-output]
//! refs: []
//! ---
//!
//! Implements the waveform-derived sequential circuit for Prob117_circuit9.
//! The 3-bit output is a positive-edge registered value that loads 4 while
//! input a is asserted, then counts upward modulo 7 when a is deasserted.
/// Top-level waveform-derived sequential circuit.
///
/// Input a is sampled on the rising edge of clk. Output q is a one-cycle
/// registered 3-bit value with no reset: when a is high the next q is 4;
/// otherwise q advances modulo 7, wrapping from 6 to 0.
module TopModule (
  input logic clk,
  input logic a,
  output logic [2:0] q
);

  always_ff @(posedge clk) begin
    if (a) begin
      q <= 3'd4;
    end else if (q == 3'd6) begin
      q <= 3'd0;
    end else begin
      q <= ($bits(q) > 3 ? $bits(q) : 3)'(q + 3'd1);
    end
  end

endmodule

