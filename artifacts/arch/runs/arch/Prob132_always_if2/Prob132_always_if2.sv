//! ---
//! spec_md: dataset_spec-to-rtl/Prob132_always_if2_prompt.txt
//! tags: [combinational, latch-fix, boolean-logic]
//! refs: []
//! ---
//!
//! Implements the corrected version of the prompt's combinational control logic.
//! The original Verilog omitted assignments on some paths, so both outputs are
//! driven for every input combination.
/// Corrected combinational computer shutdown and driving-control logic.
///
/// shut_off_computer is asserted when cpu_overheated is true. keep_driving is
/// asserted only while the destination has not been reached and the gas tank is
/// not empty.
module TopModule (
  input logic cpu_overheated,
  output logic shut_off_computer,
  input logic arrived,
  input logic gas_tank_empty,
  output logic keep_driving
);

  assign shut_off_computer = cpu_overheated;
  assign keep_driving = !arrived && !gas_tank_empty;

endmodule

