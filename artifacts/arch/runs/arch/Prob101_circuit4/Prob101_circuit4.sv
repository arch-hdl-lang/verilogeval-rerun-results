//! ---
//! spec_md: dataset_spec-to-rtl/Prob101_circuit4_prompt.txt
//! tags: [combinational, waveform, boolean-logic]
//! ---
//!
//! Implements the waveform-derived combinational circuit for Prob101_circuit4.
//! The output is high whenever input b or input c is high; inputs a and d do not affect q.
/// Top-level combinational circuit with the exact VerilogEval interface.
/// One-bit output q is the logical OR of inputs b and c.
module TopModule (
  input logic a,
  input logic b,
  input logic c,
  input logic d,
  output logic q
);

  assign q = b || c;

endmodule

