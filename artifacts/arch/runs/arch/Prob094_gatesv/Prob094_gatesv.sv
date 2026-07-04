//! ---
//! tags: [combinational, gates, vector-neighbor]
//! ---
//!
//! Implements the four-bit neighbor relationship logic from the Prob094_gatesv prompt.
//! Boundary bits that have no requested neighbor are driven to zero, while the difference output wraps at the left edge.
/// Four-bit combinational neighbor gate network.
///
/// Produces adjacent-pair AND, OR, and wraparound XOR relationship vectors for the input.
module TopModule (
  input logic [3:0] in,
  output logic [3:0] out_both,
  output logic [3:0] out_any,
  output logic [3:0] out_different
);

  assign out_both = {1'd0, in[2] & in[3], in[1] & in[2], in[0] & in[1]};
  assign out_any = {in[3] | in[2], in[2] | in[1], in[1] | in[0], 1'd0};
  assign out_different = {in[3] ^ in[0], in[2] ^ in[3], in[1] ^ in[2], in[0] ^ in[1]};

endmodule

