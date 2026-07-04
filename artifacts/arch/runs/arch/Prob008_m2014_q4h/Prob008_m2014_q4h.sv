//! ---
//! spec_md: dataset_spec-to-rtl/Prob008_m2014_q4h_prompt.txt
//! tags: [combinational, passthrough, verilog-eval]
//! refs: []
//! ---
//!
//! Implements a one-bit combinational passthrough. The output reflects the input in the same cycle with no storage.
/// One-bit combinational passthrough top module.
///
/// Drives `out` directly from `in` as required by the problem statement.
module TopModule (
  input logic in,
  output logic out
);

  assign out = in;

endmodule

