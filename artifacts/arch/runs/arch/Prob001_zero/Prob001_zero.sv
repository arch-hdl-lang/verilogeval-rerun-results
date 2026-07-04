//! ---
//! spec_md: dataset_spec-to-rtl/Prob001_zero_prompt.txt
//! tags: [constant-output, combinational, zero]
//! ---
//!
//! Implements the Prob001_zero prompt as a constant-low combinational output.
/// Top-level module for Prob001_zero.
///
/// Drives the single output LOW at all times.
module TopModule (
  output logic zero
);

  assign zero = 1'b0;

endmodule

