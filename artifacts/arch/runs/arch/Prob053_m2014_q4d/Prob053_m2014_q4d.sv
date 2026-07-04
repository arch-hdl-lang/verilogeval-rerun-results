//! ---
//! spec_md: dataset_spec-to-rtl/Prob053_m2014_q4d_prompt.txt
//! tags: [dff, xor, sequential]
//! refs: []
//! ---
//!
//! Implements a one-bit positive-edge D flip-flop whose next value is the XOR
//! of the external input and the current flip-flop output. The design has no reset.
/// Positive-edge one-bit XOR feedback flip-flop.
module TopModule (
  input logic clk,
  input logic in,
  output logic out
);

  logic stored;
  assign out = stored;
  always_ff @(posedge clk) begin
    stored <= stored ^ in;
  end

endmodule

