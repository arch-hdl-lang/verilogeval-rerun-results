//! ---
//! spec_md: dataset_spec-to-rtl/Prob051_gates4_prompt.txt
//! tags: [gates, combinational, reduction]
//! ---
//!
//! Implements the Prob051_gates4 combinational reductions over a 4-bit input.
/// Top-level four-input gate reduction module.
///
/// Produces AND, OR, and XOR reductions of in[3:0] with same-cycle combinational outputs.
module TopModule (
  input logic [3:0] in,
  output logic out_and,
  output logic out_or,
  output logic out_xor
);

  assign out_and = in[3] & in[2] & in[1] & in[0];
  assign out_or = in[3] | in[2] | in[1] | in[0];
  assign out_xor = in[3] ^ in[2] ^ in[1] ^ in[0];

endmodule

