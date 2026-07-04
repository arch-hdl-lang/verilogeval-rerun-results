//! ---
//! spec_md: dataset_spec-to-rtl/Prob053_m2014_q4d_prompt.txt
//! tags: [dff, xor, sequential]
//! refs: []
//! ---
//!
//! Implements a one-bit positive-edge D flip-flop whose next value is the XOR
//! of the external input and the current flip-flop output. The design has no reset.
/// Positive-edge one-bit XOR feedback flip-flop with no reset.
module TopModule (
  input logic clk,
  input logic in,
  output logic out = 0
);

  always_ff @(posedge clk) begin
    out <= out ^ in;
  end

endmodule

