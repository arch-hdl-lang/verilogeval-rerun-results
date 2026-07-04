//! ---
//! spec_md: dataset_spec-to-rtl/Prob036_ringer_prompt.txt
//! tags: [ringer, vibration, cellphone, combinational]
//! refs: []
//! ---
//!
//! Cellphone alert selector for an incoming call. When ring is asserted,
//! vibrate_mode selects the vibration motor; otherwise the audible ringer is
//! selected, and both outputs are never asserted together.
/// Top-level combinational cellphone ringer/vibration controller.
///
/// The module preserves the requested VerilogEval interface exactly with
/// one-bit logical inputs and outputs.
module TopModule (
  input logic ring,
  input logic vibrate_mode,
  output logic ringer,
  output logic motor
);

  assign motor = ring && vibrate_mode;
  assign ringer = ring && !vibrate_mode;

endmodule

