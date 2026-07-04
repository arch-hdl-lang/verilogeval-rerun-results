//! ---
//! spec_md: dataset_spec-to-rtl/Prob009_popcount3_prompt.txt
//! tags: [popcount, combinational, vector-count]
//! refs: []
//! ---
//!
//! Implements the VerilogEval Prob009_popcount3 prompt as a combinational three-bit population count.
/// Top-level combinational population count circuit.
///
/// Counts the number of asserted bits in the 3-bit input vector and returns the count as a 2-bit value.
module TopModule (
  input logic [2:0] in,
  output logic [1:0] out
);

  logic bit0;
  logic bit1;
  logic bit2;
  logic count_lsb;
  logic count_msb;
  assign bit0 = in[0];
  assign bit1 = in[1];
  assign bit2 = in[2];
  assign count_lsb = bit0 ^ bit1 ^ bit2;
  assign count_msb = bit0 && bit1 || bit0 && bit2 || bit1 && bit2;
  assign out = {count_msb, count_lsb};

endmodule

