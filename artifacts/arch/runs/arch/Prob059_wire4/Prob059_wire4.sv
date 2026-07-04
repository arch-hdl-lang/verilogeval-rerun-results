//! ---
//! spec_md: dataset_spec-to-rtl/Prob059_wire4_prompt.txt
//! tags: [wires, combinational, routing]
//! refs: []
//! ---
//!
//! Implements the requested one-bit wire routing for TopModule.
/// Top-level combinational wire routing module.
///
/// Connects a to w, b to x and y, and c to z with no storage or timing latency.
module TopModule (
  input logic a,
  input logic b,
  input logic c,
  output logic w,
  output logic x,
  output logic y,
  output logic z
);

  assign w = a;
  assign x = b;
  assign y = b;
  assign z = c;

endmodule

