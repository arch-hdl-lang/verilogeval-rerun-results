//! ---
//! spec_md: dataset_spec-to-rtl/Prob083_mt2015_q4b_prompt.txt
//! tags: [combinational, waveform, equality]
//! refs: []
//! ---
//!
//! Waveform-derived combinational logic for VerilogEval Prob083_mt2015_q4b.
//! The output is high for input combinations 00 and 11, and low for 01 and 10.
/// Top-level combinational equality detector.
///
/// Timing/type note: inputs x and y are level-sensitive one-bit Bool signals.
/// Output z is a combinational Bool output with zero registered latency.
///
/// Truth table:
/// | input condition | current state | next state | output |
/// | x=0, y=0 | combinational | combinational | z=1 |
/// | x=0, y=1 | combinational | combinational | z=0 |
/// | x=1, y=0 | combinational | combinational | z=0 |
/// | x=1, y=1 | combinational | combinational | z=1 |
module TopModule (
  input logic x,
  input logic y,
  output logic z
);

  assign z = x == y;

endmodule

