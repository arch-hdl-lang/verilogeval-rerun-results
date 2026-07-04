//! ---
//! spec_md: dataset_spec-to-rtl/Prob050_kmap1_prompt.txt
//! tags: [kmap, combinational, boolean]
//! refs: []
//! ---
//!
//! Implements the requested three-input Karnaugh-map circuit. The map is one
//! for every input combination except a=0, b=0, c=0.
/// Top-level combinational implementation for the Prob050_kmap1 K-map.
///
/// Inputs and output are single-bit logical signals; out is high for every
/// minterm except 000.
module TopModule (
  input logic a,
  input logic b,
  input logic c,
  output logic out
);

  assign out = a || b || c;

endmodule

