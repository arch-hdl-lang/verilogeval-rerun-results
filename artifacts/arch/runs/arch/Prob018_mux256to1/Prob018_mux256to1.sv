//! ---
//! spec_md: dataset_spec-to-rtl/Prob018_mux256to1_prompt.txt
//! tags: [mux, combinational, bit_select]
//! refs: []
//! ---
//!
//! Implements the VerilogEval Prob018_mux256to1 prompt as a combinational
//! 1-bit-wide, 256-input multiplexer packed into a single input vector.
/// Top-level combinational 256-to-1 mux.
///
/// The 8-bit selector chooses one bit from the 256-bit packed input vector,
/// with selector value zero mapped to bit zero.
module TopModule (
  input logic [255:0] in,
  input logic [7:0] sel,
  output logic out
);

  assign out = in[sel];

endmodule

