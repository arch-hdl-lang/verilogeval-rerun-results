//! ---
//! spec_md: dataset_spec-to-rtl/Prob092_gatesv100_prompt.txt
//! tags: [gates, vector_logic, combinational]
//! ---
//!
//! Implements the Prob092_gatesv100 vector-neighbor gate operations as a pure
//! combinational top-level module with the requested VerilogEval interface.
/// Computes per-bit neighbour relations for a 100-bit input vector.
///
/// `out_both` compares each bit with the neighbour at the next higher index,
/// forcing bit 99 to zero. `out_any` compares each bit with the neighbour at
/// the next lower index, forcing bit 0 to zero. `out_different` compares with
/// the next higher index and wraps bit 99 around to bit 0.
module TopModule (
  input logic [99:0] in,
  output logic [99:0] out_both,
  output logic [99:0] out_any,
  output logic [99:0] out_different
);

  assign out_both = {1'd0, in[98:0] & in[99:1]};
  assign out_any = {in[99:1] | in[98:0], 1'd0};
  assign out_different = {in[99] ^ in[0], in[98:0] ^ in[99:1]};

endmodule

