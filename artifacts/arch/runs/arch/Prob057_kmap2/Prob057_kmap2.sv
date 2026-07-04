//! ---
//! spec_md: dataset_spec-to-rtl/Prob057_kmap2_prompt.txt
//! tags: [kmap, combinational, boolean-logic]
//! refs: []
//! ---
//!
//! Implements the one-bit combinational output defined by the Prob057_kmap2 Karnaugh map.
/// Top-level combinational logic for the requested Karnaugh-map truth table.
module TopModule (
  input logic a,
  input logic b,
  input logic c,
  input logic d,
  output logic out
);

  logic m0000;
  logic m0100;
  logic m1000;
  logic m0001;
  logic m1001;
  logic m0111;
  logic m1111;
  logic m1011;
  logic m0010;
  logic m0110;
  assign m0000 = !a && !b && !c && !d;
  assign m0100 = !a && b && !c && !d;
  assign m1000 = a && !b && !c && !d;
  assign m0001 = !a && !b && !c && d;
  assign m1001 = a && !b && !c && d;
  assign m0111 = !a && b && c && d;
  assign m1111 = a && b && c && d;
  assign m1011 = a && !b && c && d;
  assign m0010 = !a && !b && c && !d;
  assign m0110 = !a && b && c && !d;
  assign out = m0000 || m0100 || m1000 || m0001 || m1001 || m0111 || m1111 || m1011 || m0010 || m0110;

endmodule

