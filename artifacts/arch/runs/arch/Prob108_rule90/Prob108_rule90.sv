//! ---
//! spec_md: dataset_spec-to-rtl/Prob108_rule90_prompt.txt
//! tags: [rule90, cellular-automaton, sequential-state]
//! refs: []
//! ---
//!
//! Implements a 512-cell Rule 90 cellular automaton. The state loads from data
//! when load is asserted, otherwise each clock edge advances q using the XOR of
//! the two neighboring cells with zero-valued boundaries.
/// 512-bit Rule 90 cellular automaton top module.
///
/// Samples load and data on the positive edge of clk. The q output is the
/// registered automaton state.
module TopModule (
  input logic clk,
  input logic load,
  input logic [511:0] data,
  output logic [511:0] q
);

  always_ff @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= q << 1 ^ q >> 1;
    end
  end

endmodule

