//! ---
//! spec_md: dataset_spec-to-rtl/Prob002_m2014_q4i_prompt.txt
//! tags: [constant-output, combinational, zero]
//! ---
//!
//! Implements the Prob002_m2014_q4i prompt as a constant-low combinational output.
/// Top-level module for Prob002_m2014_q4i.
///
/// Drives the single output LOW at all times.
module TopModule (
  output logic out
);

  assign out = 1'b0;

endmodule

