//! ---
//! spec_md: dataset_spec-to-rtl/Prob006_vectorr_prompt.txt
//! tags: [bit_reverse, vector, combinational]
//! refs: []
//! ---
//!
//! Implements the Prob006_vectorr prompt: an 8-bit input vector is bit-reversed onto an 8-bit output vector with no registered latency.
/// Combinational 8-bit bit-order reversal module.
///
/// The least-significant input bit becomes the most-significant output bit, and so on across the full byte.
module TopModule (
  input logic [7:0] in,
  output logic [7:0] out
);

  assign out = {<<1{in}};

endmodule

