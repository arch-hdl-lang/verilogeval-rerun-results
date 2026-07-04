//! ---
//! spec_md: dataset_spec-to-rtl/Prob010_mt2015_q4a_prompt.txt
//! tags: [boolean, combinational, xor, and]
//! refs: []
//! ---
//!
//! Implements the one-bit Boolean function requested by the VerilogEval prompt:
//! z is asserted when x is high and x differs from y.
/// One-bit combinational Boolean function for Prob010_mt2015_q4a.
///
/// Drives z as (x ^ y) & x with no clocked state.
module TopModule (
  input logic x,
  input logic y,
  output logic z
);

  assign z = (x ^ y) & x;

endmodule

