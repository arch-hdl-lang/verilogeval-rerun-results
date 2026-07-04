//! ---
//! spec_md: dataset_spec-to-rtl/Prob027_fadd_prompt.txt
//! tags: [full_adder, combinational_logic, arithmetic]
//! ---
//!
//! Implements the requested one-bit full adder. The design combines inputs a,
//! b, and cin into a same-cycle sum bit and carry-out bit.
/// One-bit combinational full adder.
///
/// Produces sum as the parity of a, b, and cin, and cout when at least two
/// inputs are asserted.
module TopModule (
  input logic a,
  input logic b,
  input logic cin,
  output logic cout,
  output logic sum
);

  logic axb;
  assign axb = a ^ b;
  assign sum = axb ^ cin;
  assign cout = (a & b) | (a & cin) | (b & cin);

endmodule

