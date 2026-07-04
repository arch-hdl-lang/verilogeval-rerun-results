//! ---
//! spec_md: dataset_spec-to-rtl/Prob124_rule110_prompt.txt
//! tags: [cellular-automaton, rule110, sequential-logic]
//! refs: []
//! ---
//!
//! Implements a 512-cell Rule 110 cellular automaton. The state is loaded
//! synchronously from data when load is high, otherwise it advances one step
//! per positive clock edge with zero-valued boundary cells.
/// Top-level 512-bit Rule 110 automaton.
///
/// The q output is the registered cell state. Each clock edge either loads
/// data[511:0] or computes the next generation from q[511:0].
module TopModule (
  input logic clk,
  input logic load,
  input logic [511:0] data,
  output logic [511:0] q
);

  logic [511:0] left_cells;
  logic [511:0] right_cells;
  logic [511:0] next_cells;
  assign left_cells = {1'd0, q[511:1]};
  assign right_cells = {q[510:0], 1'd0};
  assign next_cells = (~left_cells & (q | right_cells)) | (left_cells & q & ~right_cells) | (left_cells & ~q & right_cells);
  always_ff @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= next_cells;
    end
  end

endmodule

