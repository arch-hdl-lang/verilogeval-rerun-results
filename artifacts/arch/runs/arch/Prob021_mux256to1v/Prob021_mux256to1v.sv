//! ---
//! spec_md: dataset_spec-to-rtl/Prob021_mux256to1v_prompt.txt
//! tags: [mux, combinational, vector-select]
//! refs: []
//! ---
//!
//! Implements the VerilogEval Prob021_mux256to1v specification as a 4-bit wide,
//! 256-to-1 combinational multiplexer over a packed 1024-bit input vector.
/// Top-level combinational 256-to-1 mux.
///
/// The 8-bit selector chooses one 4-bit lane from the packed input vector.
module TopModule (
  input logic [1023:0] in,
  input logic [7:0] sel,
  output logic [3:0] out
);

  logic [9:0] bit_offset;
  assign bit_offset = {sel, 2'd0};
  assign out = in[bit_offset +: 4];

endmodule

