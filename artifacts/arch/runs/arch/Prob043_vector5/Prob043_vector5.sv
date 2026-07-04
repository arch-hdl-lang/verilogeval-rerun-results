//! ---
//! spec_md: dataset_spec-to-rtl/Prob043_vector5_prompt.txt
//! tags: [vector, equality, combinational]
//! refs: []
//! ---
//!
//! Computes the 5 by 5 pairwise equality matrix for five one-bit inputs.
//! The output is flattened with the comparisons against a in the most
//! significant five bits and comparisons against e in the least significant five bits.
/// Top-level combinational vector equality module.
///
/// Produces all 25 pairwise comparisons for inputs a through e in prompt order.
module TopModule (
  input logic a,
  input logic b,
  input logic c,
  input logic d,
  input logic e,
  output logic [24:0] out
);

  assign out = {a == a, a == b, a == c, a == d, a == e, b == a, b == b, b == c, b == d, b == e, c == a, c == b, c == c, c == d, c == e, d == a, d == b, d == c, d == d, d == e, e == a, e == b, e == c, e == d, e == e};

endmodule

