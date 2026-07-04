//! ---
//! spec_md: dataset_spec-to-rtl/Prob004_vector2_prompt.txt
//! tags: [vector, byte-order, combinational]
//! ---
//!
//! Implements the Prob004_vector2 prompt by reversing byte order in a 32-bit vector.
/// Top-level byte-order reversal module for Prob004_vector2.
///
/// Concatenates input bytes from least-significant to most-significant byte.
module TopModule (
  input logic [31:0] in,
  output logic [31:0] out
);

  assign out = {in[7:0], in[15:8], in[23:16], in[31:24]};

endmodule

