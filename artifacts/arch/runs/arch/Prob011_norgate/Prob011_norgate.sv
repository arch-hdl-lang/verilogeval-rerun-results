//! ---
//! spec_md: dataset_spec-to-rtl/Prob011_norgate_prompt.txt
//! tags: [combinational, logic-gate, nor]
//! refs: []
//! ---
//!
//! Implements the VerilogEval Prob011_norgate specification: a one-bit
//! combinational NOR gate with inputs a and b driving output out.
/// Top-level one-bit NOR gate for Prob011_norgate.
module TopModule (
  input logic a,
  input logic b,
  output logic out
);

  assign out = !(a || b);

endmodule

