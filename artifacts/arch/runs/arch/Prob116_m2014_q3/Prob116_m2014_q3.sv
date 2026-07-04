//! ---
//! spec_md: dataset_spec-to-rtl/Prob116_m2014_q3_prompt.txt
//! tags: [kmap, combinational, boolean-logic]
//! refs: []
//! ---
//!
//! Implements the requested Karnaugh-map combinational function for TopModule.
/// Combinational boolean function derived from the supplied Karnaugh map.
///
/// The one-indexed prompt variables map onto packed vector bits as
/// x1=x[0], x2=x[1], x3=x[2], and x4=x[3].
module TopModule (
  input logic [3:0] x,
  output logic f
);

  logic x1;
  logic x2;
  logic x3;
  logic x4;
  assign x1 = x[0];
  assign x2 = x[1];
  assign x3 = x[2];
  assign x4 = x[3];
  assign f = !x1 && x3 || x2 && x4;

endmodule

