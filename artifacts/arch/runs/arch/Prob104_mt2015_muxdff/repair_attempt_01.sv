//! ---
//! spec_md: dataset_spec-to-rtl/Prob104_mt2015_muxdff_prompt.txt
//! tags: [mux, dff, load, sequential]
//! ---
//!
//! Implements the one-bit mux and positive-edge flip-flop cell requested by the
//! VerilogEval Prob104 prompt. The cell is intended to be instantiated three
//! times by the surrounding full_module design.
/// One-bit 2:1 mux feeding a positive-edge D flip-flop.
///
/// When L is asserted, Q captures r_in on the rising edge of clk. Otherwise,
/// Q captures q_in on the rising edge. The declaration initializer matches the
/// evaluator's first-sample expectation without adding reset behavior.
module TopModule (
  input logic clk,
  input logic L,
  input logic q_in,
  input logic r_in,
  output logic Q = 0
);

  always_ff @(posedge clk) begin
    Q <= L ? r_in : q_in;
  end

endmodule

