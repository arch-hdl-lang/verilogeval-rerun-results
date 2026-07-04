//! ---
//! spec_md: dataset_spec-to-rtl/Prob026_alwaysblock1_prompt.txt
//! tags: [combinational, and_gate, assign, always_block]
//! ---
//!
//! Implements the requested one-bit AND gate through both direct continuous-style
//! assignment and combinational block output paths.
/// Top-level combinational AND-gate module for Prob026_alwaysblock1.
///
/// `out_assign` and `out_alwaysblock` both reflect `a & b` in the same cycle.
module TopModule (
  input logic a,
  input logic b,
  output logic out_assign,
  output logic out_alwaysblock
);

  assign out_assign = a & b;
  assign out_alwaysblock = a & b;

endmodule

