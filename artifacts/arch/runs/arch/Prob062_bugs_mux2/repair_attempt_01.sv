//! ---
//! spec_md: dataset_spec-to-rtl/Prob062_bugs_mux2_prompt.txt
//! tags: [mux, combinational, width-fix]
//! refs: []
//! ---
//!
//! Implements the repaired 8-bit 2-to-1 mux from the prompt. The repair makes
//! the output bus width explicit and drives it with a full-width conditional mux.
/// Corrected 8-bit 2-to-1 mux top module.
///
/// Selects `b` when `sel` is low and `a` when `sel` is high, producing an
/// 8-bit same-cycle combinational output.
module TopModule (
  input logic sel,
  input logic [7:0] a,
  input logic [7:0] b,
  output logic [7:0] out
);

  assign out = sel ? a : b;

endmodule

