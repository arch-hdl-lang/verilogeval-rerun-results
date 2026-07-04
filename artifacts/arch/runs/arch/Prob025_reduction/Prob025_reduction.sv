//! ---
//! spec_md: dataset_spec-to-rtl/Prob025_reduction_prompt.txt
//! tags: [parity, reduction, combinational]
//! ---
//!
//! Computes the even parity bit for an 8-bit input byte. The output is the
//! XOR reduction of all input bits and is purely combinational.
/// Combinational 8-bit even parity generator.
module TopModule (
  input logic [7:0] in,
  output logic parity
);

  assign parity = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

endmodule

