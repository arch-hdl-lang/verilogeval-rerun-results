//! ---
//! spec_md: dataset_spec-to-rtl/Prob144_conwaylife_prompt.txt
//! tags: [conwaylife, toroidal-grid, cellular-automaton, sequential-logic]
//! ---
//!
//! Implements a 16x16 toroidal Conway's Game of Life stepper. The 256-bit
//! state is loaded synchronously when load is high; otherwise it advances one
//! generation on each rising clock edge.
/// Computes the next state for one Conway cell from its eight neighbours.
/// Top-level 16x16 toroidal Conway's Game of Life state machine.
///
/// q[15:0] is row 0 and q[255:240] is row 15. Each cell explicitly indexes
/// its wrapped north, south, west, and east neighbours instead of relying on
/// whole-vector shifts.
module TopModule (
  input logic clk,
  input logic load,
  input logic [255:0] data,
  output logic [255:0] q
);

  function automatic logic NextCell(input logic alive, input logic nw, input logic n, input logic ne, input logic w, input logic e, input logic sw, input logic s, input logic se);
    logic [3:0] neighbours = 4'((4'((4'((4'((4'((4'((4'(4'(nw) + 4'(n))) + 4'(ne))) + 4'(w))) + 4'(e))) + 4'(sw))) + 4'(s))) + 4'(se));
    return neighbours == 4'd3 || neighbours == 4'd2 && alive;
  endfunction
  
  logic [255:0] grid;
  logic [255:0] next_grid;
  assign q = grid;
  always_comb begin
    for (int row_idx = 0; row_idx <= 15; row_idx++) begin
      for (int col_idx = 0; col_idx <= 15; col_idx++) begin
        next_grid[row_idx * 16 + col_idx] = NextCell(grid[row_idx * 16 + col_idx], grid[((row_idx + 15) % 16) * 16 + (col_idx + 15) % 16], grid[((row_idx + 15) % 16) * 16 + col_idx], grid[((row_idx + 15) % 16) * 16 + (col_idx + 1) % 16], grid[row_idx * 16 + (col_idx + 15) % 16], grid[row_idx * 16 + (col_idx + 1) % 16], grid[((row_idx + 1) % 16) * 16 + (col_idx + 15) % 16], grid[((row_idx + 1) % 16) * 16 + col_idx], grid[((row_idx + 1) % 16) * 16 + (col_idx + 1) % 16]);
      end
    end
  end
  always_ff @(posedge clk) begin
    if (load) begin
      grid <= data;
    end else begin
      grid <= next_grid;
    end
  end

endmodule

