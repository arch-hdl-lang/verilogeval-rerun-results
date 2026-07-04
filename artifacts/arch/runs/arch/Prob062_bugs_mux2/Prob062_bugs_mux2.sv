//! ---
//! spec_md: dataset_spec-to-rtl/Prob062_bugs_mux2_prompt.txt
//! tags: [mux, combinational, width-fix]
//! refs: []
//! ---
//!
//! Implements the corrected 8-bit 2-to-1 mux from the prompt. The original bug
//! was a scalar output driven by an 8-bit mux expression.
/// Corrected 8-bit 2-to-1 mux top module.
///
/// Selects `a` when `sel` is low and `b` when `sel` is high, producing an
/// 8-bit combinational output.
module TopModule (
  input logic sel,
  input logic [7:0] a,
  input logic [7:0] b,
  output logic [7:0] out
);

  assign out = sel ? b : a;

endmodule

