//! ---
//! spec_md: dataset_spec-to-rtl/Prob012_xnorgate_prompt.txt
//! tags: [combinational, logic, xnor]
//! refs: []
//! ---
//!
//! Implements the Prob012_xnorgate prompt: a one-bit XNOR gate with inputs a and b and output out.
/// One-bit combinational XNOR gate.
///
/// Drives out high when a and b are equal.
module TopModule (
  input logic a,
  input logic b,
  output logic out
);

  assign out = a == b;

endmodule

