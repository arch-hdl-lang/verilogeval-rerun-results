//! ---
//! spec_md: dataset_spec-to-rtl/Prob147_circuit10_prompt.txt
//! tags: [sequential, waveform, flipflop, combinational]
//! refs: []
//! ---
//!
//! Implements the waveform-derived one-bit sequential circuit for Prob147_circuit10.
//! The observable state is the single positive-edge-triggered flip-flop, and q is
//! combinational logic of the current state and inputs.
/// Top-level waveform-derived one-bit sequential circuit.
///
/// Inputs are sampled on the positive edge of clk for the state update.
/// The output state is the current flip-flop value, and q is combinational.
module TopModule (
  input logic clk,
  input logic a,
  input logic b,
  output logic q,
  output logic state
);

  logic next_ff;
  logic ff;
  assign state = ff;
  assign q = ff ^ a ^ b;
  assign next_ff = a && b || ff && (a || b);
  always_ff @(posedge clk) begin
    ff <= next_ff;
  end

endmodule

