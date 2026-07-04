//! ---
//! spec_md: dataset_spec-to-rtl/Prob002_m2014_q4i_prompt.txt
//! tags: [constant-output, combinational, verilogeval]
//! ---
//!
//! Implements the VerilogEval Prob002_m2014_q4i prompt: a top-level module with a single one-bit output that is always driven logic low.
/// Top-level constant-low output module for Prob002_m2014_q4i.
module TopModule (
  output logic out
);

  assign out = 1'b0;

endmodule

