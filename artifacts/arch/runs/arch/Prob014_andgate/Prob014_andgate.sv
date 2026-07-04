//! ---
//! spec_md: dataset_spec-to-rtl/Prob014_andgate_prompt.txt
//! tags: [combinational, logic, andgate]
//! ---
//!
//! Implements the VerilogEval Prob014_andgate specification: a two-input one-bit
//! AND gate named TopModule.
/// Two-input one-bit AND gate.
///
/// Drives `out` combinationally high only when both `a` and `b` are high.
module TopModule (
  input logic a,
  input logic b,
  output logic out
);

  assign out = a & b;

endmodule

