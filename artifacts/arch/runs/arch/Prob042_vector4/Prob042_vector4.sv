//! ---
//! spec_md: dataset_spec-to-rtl/Prob042_vector4_prompt.txt
//! tags: [sign-extension, vector, combinational]
//! refs: []
//! ---
//!
//! Implements the Prob042_vector4 prompt: sign-extend an 8-bit input to a
//! 32-bit output by copying the input sign bit into the upper 24 bits.
/// Combinational top module for 8-bit to 32-bit sign extension.
module TopModule (
  input logic [7:0] in,
  output logic [31:0] out
);

  assign out = {in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], in};

endmodule

