//! ---
//! spec_md: dataset_spec-to-rtl/Prob029_m2014_q4g_prompt.txt
//! tags: [combinational, xnor, xor]
//! refs: []
//! ---
//!
//! Implements the requested one-bit combinational circuit for Prob029_m2014_q4g.
//! The output is the XOR of in3 with the XNOR of in1 and in2.
/// Top-level combinational module for the VerilogEval Prob029_m2014_q4g prompt.
///
/// Computes out as ((in1 XNOR in2) XOR in3) using one-bit Boolean ports.
module TopModule (
  input logic in1,
  input logic in2,
  input logic in3,
  output logic out
);

  assign out = (in1 == in2) ^ in3;

endmodule

