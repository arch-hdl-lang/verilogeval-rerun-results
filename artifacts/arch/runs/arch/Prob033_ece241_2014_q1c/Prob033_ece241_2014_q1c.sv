//! ---
//! spec_md: dataset_spec-to-rtl/Prob033_ece241_2014_q1c_prompt.txt
//! tags: [addition, signed-overflow, combinational]
//! refs: []
//! ---
//!
//! Implements the VerilogEval Prob033_ece241_2014_q1c combinational 8-bit
//! two's complement adder and signed-overflow detector.
/// Top-level 8-bit two's complement adder.
///
/// Produces the low 8 bits of a plus b and asserts overflow when the operands
/// have the same sign but the result sign differs.
module TopModule (
  input logic [7:0] a,
  input logic [7:0] b,
  output logic [7:0] s,
  output logic overflow
);

  logic [7:0] sum;
  logic same_sign;
  logic sign_changed;
  assign sum = 8'(a + b);
  assign same_sign = a[7] == b[7];
  assign sign_changed = sum[7] != a[7];
  assign s = sum;
  assign overflow = same_sign && sign_changed;

endmodule

