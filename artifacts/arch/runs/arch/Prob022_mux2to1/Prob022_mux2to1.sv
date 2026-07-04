//! ---
//! spec_md: dataset_spec-to-rtl/Prob022_mux2to1_prompt.txt
//! tags: [mux, combinational, one_bit]
//! ---
//!
//! Implements the requested one-bit 2-to-1 multiplexer. The output is purely
//! combinational: sel=0 selects a, and sel=1 selects b.
/// Top-level one-bit combinational 2-to-1 multiplexer.
module TopModule (
  input logic a,
  input logic b,
  input logic sel,
  output logic out
);

  assign out = sel ? b : a;

endmodule

