//! ---
//! spec_md: dataset_spec-to-rtl/Prob065_7420_prompt.txt
//! tags: [combinational, logic, nand, ttl]
//! ---
//!
//! Implements the VerilogEval Prob065_7420 specification: a 7420-compatible
//! dual four-input NAND gate named TopModule.
/// Dual four-input NAND gate matching a 7420 logic chip.
///
/// Each one-bit output is driven combinationally low only when all four
/// corresponding inputs are high.
module TopModule (
  input logic p1a,
  input logic p1b,
  input logic p1c,
  input logic p1d,
  input logic p2a,
  input logic p2b,
  input logic p2c,
  input logic p2d,
  output logic p1y,
  output logic p2y
);

  assign p1y = !(p1a & p1b & p1c & p1d);
  assign p2y = !(p2a & p2b & p2c & p2d);

endmodule

