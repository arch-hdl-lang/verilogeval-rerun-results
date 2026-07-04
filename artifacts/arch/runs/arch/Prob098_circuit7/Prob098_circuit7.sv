//! ---
//! spec_md: dataset_spec-to-rtl/Prob098_circuit7_prompt.txt
//! tags: [sequential, waveform, register]
//! ---
//!
//! Implements the waveform-derived sequential circuit for Prob098_circuit7.
//! The output is the inverse of input `a` captured on the previous positive
//! edge of `clk`, with no reset so the initial value remains unspecified.
/// Top-level sequential waveform circuit.
///
/// Input `a` is sampled on the positive edge of `clk`; output `q` is a
/// one-cycle registered inverse of the sampled input.
module TopModule (
  input logic clk,
  input logic a,
  output logic q
);

  always_ff @(posedge clk) begin
    q <= ~a;
  end

endmodule

