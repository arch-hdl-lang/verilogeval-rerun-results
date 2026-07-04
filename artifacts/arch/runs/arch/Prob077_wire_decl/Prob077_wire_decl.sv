//! ---
//! spec_md: dataset_spec-to-rtl/Prob077_wire_decl_prompt.txt
//! tags: [combinational, gates, wire-decl]
//! ---
//!
//! Implements the requested two-level gate circuit for Prob077_wire_decl.
//! The output out is the OR of two AND gate results, and out_n is its inversion.
/// Top-level combinational gate network for the VerilogEval wire declaration problem.
module TopModule (
  input logic a,
  input logic b,
  input logic c,
  input logic d,
  output logic out,
  output logic out_n
);

  logic and_ab;
  logic and_cd;
  assign and_ab = a && b;
  assign and_cd = c && d;
  assign out = and_ab || and_cd;
  assign out_n = !out;

endmodule

