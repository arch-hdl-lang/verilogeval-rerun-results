//! ---
//! spec_md: dataset_spec-to-rtl/Prob056_ece241_2013_q7_prompt.txt
//! tags: [flip_flop, jk, sequential]
//! refs: []
//! ---
//!
//! Implements the VerilogEval Prob056_ece241_2013_q7 prompt as a JK flip-flop.
//! The output updates on the positive edge of clk using the specified J/K truth table.
/// Top-level JK flip-flop with the exact requested VerilogEval interface.
///
/// Inputs j and k are sampled on the rising edge of clk. Output Q is the
/// registered flip-flop state: hold, reset, set, or toggle based on j/k.
module TopModule (
  input logic clk,
  input logic j,
  input logic k,
  output logic Q
);

  always_ff @(posedge clk) begin
    if (j && k) begin
      Q <= ~Q;
    end else if (j) begin
      Q <= 1'b1;
    end else if (k) begin
      Q <= 1'b0;
    end else begin
      Q <= Q;
    end
  end

endmodule

