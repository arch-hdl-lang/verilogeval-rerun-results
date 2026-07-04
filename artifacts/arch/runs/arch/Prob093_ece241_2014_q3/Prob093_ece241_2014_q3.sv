//! ---
//! spec_md: dataset_spec-to-rtl/Prob093_ece241_2014_q3_prompt.txt
//! tags: [kmap, multiplexer, combinational]
//! refs: []
//! ---
//!
//! Implements mux data-input generation for the VerilogEval ECE241 K-map problem.
//! The output vector drives an external 4-to-1 mux selected by {a,b}, with
//! binary select values 00, 01, 10, and 11 mapped to mux_in[0], [1], [2], and [3].
///
/// Combinational TopModule for deriving the four external 4-to-1 mux data inputs.
///
/// K-map column functions are encoded as mux-style ternaries over c and d:
/// mux_in[0] = c ? 1 : d, mux_in[1] = 0, mux_in[2] = c ? 1 : ~d,
/// and mux_in[3] = c ? d : 0.
module TopModule (
  input logic c,
  input logic d,
  output logic [3:0] mux_in
);

  logic mux0;
  logic mux1;
  logic mux2;
  logic mux3;
  assign mux0 = c ? 1'b1 : d;
  assign mux1 = 1'b0;
  assign mux2 = c ? 1'b1 : ~d;
  assign mux3 = c ? d : 1'b0;
  assign mux_in = {mux3, mux2, mux1, mux0};

endmodule

