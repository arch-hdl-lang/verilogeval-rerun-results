//! ---
//! spec_md: dataset_spec-to-rtl/Prob058_alwaysblock2_prompt.txt
//! tags: [xor, combinational, sequential]
//! refs: []
//! ---
//!
//! Implements the requested three XOR outputs for the VerilogEval alwaysblock2 problem.
/// Top-level VerilogEval module preserving the requested interface.
///
/// `out_assign` and `out_always_comb` are combinational XOR outputs, while
/// `out_always_ff` captures the XOR result on the positive clock edge.
module TopModule (
  input logic clk,
  input logic a,
  input logic b,
  output logic out_assign,
  output logic out_always_comb,
  output logic out_always_ff
);

  assign out_assign = a ^ b;
  assign out_always_comb = a ^ b;
  always_ff @(posedge clk) begin
    out_always_ff <= a ^ b;
  end

endmodule

