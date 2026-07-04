//! ---
//! spec_md: dataset_spec-to-rtl/Prob090_circuit1_prompt.txt
//! tags: [combinational, waveform, and_gate]
//! refs: []
//! ---
//!
//! Implements the TopModule combinational circuit inferred from the provided waveform.
/// One-bit combinational circuit whose output is high only when both inputs are high.
module TopModule (
  input logic a,
  input logic b,
  output logic q
);

  assign q = a && b;

endmodule

