//! ---
//! spec_md: dataset_spec-to-rtl/Prob087_gates_prompt.txt
//! tags: [combinational, gates, boolean]
//! refs: []
//! ---
//!
//! Implements the Prob087_gates prompt as a two-input combinational gate block.
//! All ports are one-bit Bool signals, and each output directly reflects the named Boolean operation on a and b.
/// Top-level combinational gate module for Prob087_gates.
///
/// Produces AND, OR, XOR, NAND, NOR, XNOR, and A-and-not-B outputs from one-bit inputs a and b.
module TopModule (
  input logic a,
  input logic b,
  output logic out_and,
  output logic out_or,
  output logic out_xor,
  output logic out_nand,
  output logic out_nor,
  output logic out_xnor,
  output logic out_anotb
);

  assign out_and = a && b;
  assign out_or = a || b;
  assign out_xor = a ^ b;
  assign out_nand = !(a && b);
  assign out_nor = !(a || b);
  assign out_xnor = !(a ^ b);
  assign out_anotb = a && !b;

endmodule

