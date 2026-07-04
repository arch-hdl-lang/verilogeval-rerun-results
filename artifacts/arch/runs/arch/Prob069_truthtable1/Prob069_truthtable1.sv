//! ---
//! spec_md: dataset_spec-to-rtl/Prob069_truthtable1_prompt.txt
//! tags: [truth-table, combinational, boolean-logic]
//! refs: []
//! ---
//!
//! Implements the requested one-bit combinational truth table for x3, x2, x1.
//! The output f is high for rows 010, 011, 101, and 111.
/// One-bit combinational truth-table implementation for VerilogEval Prob069_truthtable1.
///
/// Ports preserve the requested TopModule interface exactly: inputs x3, x2, x1 and output f.
module TopModule (
  input logic x3,
  input logic x2,
  input logic x1,
  output logic f
);

  logic row_010;
  logic row_011;
  logic row_101;
  logic row_111;
  assign row_010 = !x3 && x2 && !x1;
  assign row_011 = !x3 && x2 && x1;
  assign row_101 = x3 && !x2 && x1;
  assign row_111 = x3 && x2 && x1;
  assign f = row_010 || row_011 || row_101 || row_111;

endmodule

