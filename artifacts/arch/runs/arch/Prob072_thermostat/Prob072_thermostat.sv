//! ---
//! spec_md: dataset_spec-to-rtl/Prob072_thermostat_prompt.txt
//! tags: [thermostat, combinational, hvac]
//! refs: []
//! ---
//!
//! Combinational thermostat controller for heating and cooling modes.
//! The user fan request is ORed with active HVAC circulation demand.
/// Top-level thermostat controller preserving the requested VerilogEval interface.
///
/// In heating mode, `heater` follows `too_cold` and `aircon` is off. In cooling
/// mode, `aircon` follows `too_hot` and `heater` is off; `fan` is on when either
/// HVAC output is active or the user requests fan operation.
module TopModule (
  input logic mode,
  input logic too_cold,
  input logic too_hot,
  input logic fan_on,
  output logic heater,
  output logic aircon,
  output logic fan
);

  assign heater = mode && too_cold;
  assign aircon = !mode && too_hot;
  assign fan = heater || aircon || fan_on;

endmodule

