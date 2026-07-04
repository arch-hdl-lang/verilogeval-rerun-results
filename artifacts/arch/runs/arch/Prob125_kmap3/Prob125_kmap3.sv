//! ---
//! spec_md: dataset_spec-to-rtl/Prob125_kmap3_prompt.txt
//! tags: [kmap, combinational, boolean]
//! refs: []
//! ---
//!
//! Implements the Prob125_kmap3 Karnaugh-map logic for TopModule.
//! The output is combinational, and the allowed don't-care cells are chosen to simplify the function.
/// Combinational TopModule for the requested one-bit K-map.
///
/// Implements out = a or (c and not b); input d is ignored because it is only relevant to don't-care grouping.
module TopModule (
  input logic a,
  input logic b,
  input logic c,
  input logic d,
  output logic out
);

  logic use_c_when_b_clear;
  assign use_c_when_b_clear = c && !b;
  assign out = a || use_c_when_b_clear;

endmodule

