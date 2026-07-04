//! ---
//! spec_md: dataset_spec-to-rtl/Prob005_notgate_prompt.txt
//! tags: [not-gate, combinational, boolean]
//! ---
//!
//! Implements the Prob005_notgate prompt as a one-bit combinational inverter.
/// Top-level NOT gate module for Prob005_notgate.
///
/// Drives the output with the logical inverse of the input.
module TopModule (
  input logic in,
  output logic out
);

  assign out = !in;

endmodule

