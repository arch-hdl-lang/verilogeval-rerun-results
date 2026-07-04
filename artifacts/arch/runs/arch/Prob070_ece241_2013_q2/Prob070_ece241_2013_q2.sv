//! ---
//! spec_md: dataset_spec-to-rtl/Prob070_ece241_2013_q2_prompt.txt
//! tags: [combinational-logic, boolean-minimization, sop-pos]
//! ---
//!
//! Implements the minimized four-input logic functions requested by the
//! VerilogEval prompt. Inputs `a,b,c,d` encode the minterm number with `a`
//! as the most-significant bit.
/// Combinational top-level module for the minimized SOP and POS outputs.
///
/// `out_sop` is the minimum sum-of-products expression for minterms 2, 7,
/// and 15 using don't-care inputs 3, 8, 11, and 12. `out_pos` is the
/// equivalent minimum product-of-sums expression for the same function.
module TopModule (
  input logic a,
  input logic b,
  input logic c,
  input logic d,
  output logic out_sop,
  output logic out_pos
);

  assign out_sop = c && d || c && !a && !b;
  assign out_pos = c && (b || !a) && (d || !b);

endmodule

