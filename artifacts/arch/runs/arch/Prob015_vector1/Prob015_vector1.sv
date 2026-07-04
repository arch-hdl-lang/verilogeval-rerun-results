//! ---
//! spec_md: dataset_spec-to-rtl/Prob015_vector1_prompt.txt
//! tags: [vector, bit-slice, combinational]
//! refs: []
//! ---
//!
//! Implements a combinational 16-bit half-word splitter into upper and lower bytes.
/// Top-level combinational byte splitter for the VerilogEval Prob015_vector1 prompt.
module TopModule (
  input logic [15:0] in,
  output logic [7:0] out_hi,
  output logic [7:0] out_lo
);

  assign out_hi = in[15:8];
  assign out_lo = in[7:0];

endmodule

