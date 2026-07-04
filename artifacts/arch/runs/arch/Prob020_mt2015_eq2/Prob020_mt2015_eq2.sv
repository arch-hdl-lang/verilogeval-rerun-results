//! ---
//! spec_md: dataset_spec-to-rtl/Prob020_mt2015_eq2_prompt.txt
//! tags: [combinational, equality, comparator]
//! refs: []
//! ---
//!
//! Implements a combinational two-bit equality comparator. The output is high
//! exactly when both input vectors have the same value.
/// Top-level two-bit equality comparator.
///
/// Drives z as a same-cycle combinational comparison of A and B.
module TopModule (
  input logic [1:0] A,
  input logic [1:0] B,
  output logic z
);

  assign z = A == B;

endmodule

