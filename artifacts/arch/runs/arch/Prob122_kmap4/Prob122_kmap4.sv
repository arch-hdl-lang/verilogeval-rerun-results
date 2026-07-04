//! ---
//! spec_md: dataset_spec-to-rtl/Prob122_kmap4_prompt.txt
//! tags: [kmap, combinational, boolean, parity]
//! refs: []
//! ---
//!
//! Implements the requested four-input Karnaugh map as a same-cycle combinational output.
/// Top-level combinational implementation of the requested K-map.
///
/// The map is true for odd parity across a, b, c, and d.
module TopModule (
  input logic a,
  input logic b,
  input logic c,
  input logic d,
  output logic out
);

  assign out = a ^ b ^ c ^ d;

endmodule

