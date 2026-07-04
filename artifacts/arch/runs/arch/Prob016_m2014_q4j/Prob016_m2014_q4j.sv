//! ---
//! spec_md: dataset_spec-to-rtl/Prob016_m2014_q4j_prompt.txt
//! tags: [adder, combinational, arithmetic]
//! refs: []
//! ---
//!
//! Implements the VerilogEval Prob016_m2014_q4j prompt: a combinational 4-bit
//! adder whose 5-bit output includes the carry-out overflow bit.
/// Top-level combinational 4-bit adder.
///
/// Adds the two 4-bit inputs and exposes the 5-bit result including carry-out.
module TopModule (
  input logic [3:0] x,
  input logic [3:0] y,
  output logic [4:0] sum
);

  logic c0;
  logic s0;
  logic c1;
  logic s1;
  logic c2;
  logic s2;
  logic c3;
  logic s3;
  logic c4;
  assign c0 = 1'b0;
  assign s0 = x[0] ^ y[0] ^ c0;
  assign c1 = (x[0] & y[0]) | (x[0] & c0) | (y[0] & c0);
  assign s1 = x[1] ^ y[1] ^ c1;
  assign c2 = (x[1] & y[1]) | (x[1] & c1) | (y[1] & c1);
  assign s2 = x[2] ^ y[2] ^ c2;
  assign c3 = (x[2] & y[2]) | (x[2] & c2) | (y[2] & c2);
  assign s3 = x[3] ^ y[3] ^ c3;
  assign c4 = (x[3] & y[3]) | (x[3] & c3) | (y[3] & c3);
  assign sum = {c4, s3, s2, s1, s0};

endmodule

