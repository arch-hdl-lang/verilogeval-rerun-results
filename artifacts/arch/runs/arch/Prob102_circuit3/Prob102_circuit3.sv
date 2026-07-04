//! ---
//! spec_md: dataset_spec-to-rtl/Prob102_circuit3_prompt.txt
//! tags: [combinational, truth-table, boolean-logic]
//! ---
//!
//! Implements the combinational circuit inferred from the supplied waveform table.
//! The output is asserted when either a or b is high and either c or d is high.
/// Top-level combinational circuit for Prob102_circuit3.
///
/// Preserves the requested one-bit ports and drives q without registered latency.
module TopModule (
  input logic a,
  input logic b,
  input logic c,
  input logic d,
  output logic q
);

  assign q = (a || b) && (c || d);

endmodule

