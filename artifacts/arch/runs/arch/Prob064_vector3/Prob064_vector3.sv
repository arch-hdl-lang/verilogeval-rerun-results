//! ---
//! spec_md: dataset_spec-to-rtl/Prob064_vector3_prompt.txt
//! tags: [vector, concat, split, combinational]
//! refs: []
//! ---
//!
//! Combinational vector packing for VerilogEval Prob064_vector3. Six 5-bit
//! input vectors are concatenated with two trailing one bits and split into
//! four 8-bit outputs.
/// Packs six 5-bit vectors and two constant one bits into four 8-bit outputs.
module TopModule (
  input logic [4:0] a,
  input logic [4:0] b,
  input logic [4:0] c,
  input logic [4:0] d,
  input logic [4:0] e,
  input logic [4:0] f,
  output logic [7:0] w,
  output logic [7:0] x,
  output logic [7:0] y,
  output logic [7:0] z
);

  logic [31:0] all_bits;
  assign all_bits = {a, b, c, d, e, f, 2'd3};
  assign w = all_bits[31:24];
  assign x = all_bits[23:16];
  assign y = all_bits[15:8];
  assign z = all_bits[7:0];

endmodule

