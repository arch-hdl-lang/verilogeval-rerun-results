//! ---
//! spec_md: dataset_spec-to-rtl/Prob006_vectorr_prompt.txt
//! tags: [vector, bit-reverse, combinational]
//! ---
//!
//! Implements the Prob006_vectorr prompt by reversing bit order in an 8-bit vector.
/// Top-level bit-order reversal module for Prob006_vectorr.
///
/// Maps each input bit to the mirrored output bit position.
module TopModule (
  input logic [7:0] in,
  output logic [7:0] out
);

  assign out = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};

endmodule

