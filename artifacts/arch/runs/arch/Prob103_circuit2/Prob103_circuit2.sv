//! ---
//! spec_md: dataset_spec-to-rtl/Prob103_circuit2_prompt.txt
//! tags: [combinational, truth-table, parity]
//! refs: []
//! ---
//!
//! Implements the Prob103_circuit2 waveform-derived combinational circuit.
//! The output is high for input combinations with even parity across a, b, c,
//! and d.
/// Top-level combinational circuit for Prob103_circuit2.
///
/// Preserves the requested one-bit input and output interface while driving q
/// from the even-parity relation indicated by the waveform table.
module TopModule (
  input logic a,
  input logic b,
  input logic c,
  input logic d,
  output logic q
);

  assign q = !(a ^ b ^ c ^ d);

endmodule

