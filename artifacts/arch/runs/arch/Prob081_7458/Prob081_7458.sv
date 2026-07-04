//! ---
//! spec_md: dataset_spec-to-rtl/Prob081_7458_prompt.txt
//! tags: [combinational, gates, ttl7458]
//! ---
//!
//! Implements the requested 7458-style combinational gate network with two OR outputs fed by four AND terms.
/// Top-level 7458-compatible combinational logic block.
///
/// p1y is the OR of two three-input AND terms, and p2y is the OR of two two-input AND terms.
module TopModule (
  input logic p1a,
  input logic p1b,
  input logic p1c,
  input logic p1d,
  input logic p1e,
  input logic p1f,
  input logic p2a,
  input logic p2b,
  input logic p2c,
  input logic p2d,
  output logic p1y,
  output logic p2y
);

  logic p1_term0;
  logic p1_term1;
  logic p2_term0;
  logic p2_term1;
  assign p1_term0 = p1a && p1b && p1c;
  assign p1_term1 = p1d && p1e && p1f;
  assign p2_term0 = p2a && p2b;
  assign p2_term1 = p2c && p2d;
  assign p1y = p1_term0 || p1_term1;
  assign p2y = p2_term0 || p2_term1;

endmodule

