//! ---
//! spec_md: dataset_spec-to-rtl/Prob055_conditional_prompt.txt
//! tags: [conditional, comparator, minimum, combinational]
//! refs: []
//! ---
//!
//! Implements the VerilogEval Prob055_conditional prompt as a combinational
//! unsigned minimum selector over four 8-bit inputs.
/// Top-level combinational datapath for selecting the minimum of four unsigned
/// 8-bit inputs while preserving the requested VerilogEval interface.
module TopModule (
  input logic [7:0] a,
  input logic [7:0] b,
  input logic [7:0] c,
  input logic [7:0] d,
  output logic [7:0] min
);

  logic [7:0] ab_min;
  logic [7:0] cd_min;
  assign ab_min = a < b ? a : b;
  assign cd_min = c < d ? c : d;
  assign min = ab_min < cd_min ? ab_min : cd_min;

endmodule

