//! ---
//! spec_md: dataset_spec-to-rtl/Prob044_vectorgates_prompt.txt
//! tags: [vector, gates, combinational]
//! ---
//!
//! Implements the Prob044 vector gate prompt as pure combinational logic.
//! The module computes a bitwise vector OR, a scalar logical OR over the
//! nonzero-ness of both vectors, and the concatenated bitwise inversions.
/// Top-level combinational vector gate module for Prob044.
///
/// Produces bitwise OR, logical OR, and concatenated NOT outputs from two
/// 3-bit input vectors while preserving the requested VerilogEval interface.
module TopModule (
  input logic [2:0] a,
  input logic [2:0] b,
  output logic [2:0] out_or_bitwise,
  output logic out_or_logical,
  output logic [5:0] out_not
);

  assign out_or_bitwise = a | b;
  assign out_or_logical = a != 3'd0 || b != 3'd0;
  assign out_not = {~b, ~a};

endmodule

