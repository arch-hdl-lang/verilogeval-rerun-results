//! ---
//! spec_md: dataset_spec-to-rtl/Prob003_step_one_prompt.txt
//! tags: [constant-output, combinational, one]
//! ---
//!
//! Implements the Prob003_step_one prompt as a constant-high combinational output.
/// Top-level module for Prob003_step_one.
///
/// Drives the single output HIGH at all times.
module TopModule (
  output logic one
);

  assign one = 1'b1;

endmodule

