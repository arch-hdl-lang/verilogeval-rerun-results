//! ---
//! spec_md: dataset_spec-to-rtl/Prob019_m2014_q4f_prompt.txt
//! tags: [combinational, logic_gate, inversion]
//! refs: []
//! ---
//!
//! Implements the requested two-input combinational gate with a bubble on
//! the second AND input.
/// Top-level combinational module for Prob019_m2014_q4f.
///
/// Drives out high only when in1 is high and in2 is low.
module TopModule (
  input logic in1,
  input logic in2,
  output logic out
);

  assign out = in1 && !in2;

endmodule

