//! ---
//! spec_md: dataset_spec-to-rtl/Prob017_mux2to1v_prompt.txt
//! tags: [multiplexer, combinational, vector_select]
//! refs: []
//! ---
//!
//! Implements the Prob017_mux2to1v prompt as a purely combinational 100-bit
//! two-input multiplexer. The output chooses input a when sel is low and input
//! b when sel is high.
/// Top-level 100-bit 2:1 multiplexer.
///
/// This module exposes the exact VerilogEval interface and drives out
/// combinationally from sel, a, and b.
module TopModule (
  input logic [99:0] a,
  input logic [99:0] b,
  input logic sel,
  output logic [99:0] out
);

  assign out = sel ? b : a;

endmodule

