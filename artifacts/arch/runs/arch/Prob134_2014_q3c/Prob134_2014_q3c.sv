//! ---
//! spec_md: dataset_spec-to-rtl/Prob134_2014_q3c_prompt.txt
//! tags: [fsm, next_state, truth_table]
//! refs: []
//! ---
//!
//! Implements the prompt's FSM next-state and output table as combinational
//! logic. The input y is the present state, Y0 is bit 0 of the next-state
//! value, and z is derived from the present state row.
/// Combinational top module for the specified FSM table.
///
/// Input timing/type: clk is a preserved top-level clock input and is unused;
/// x and y are combinational inputs. Output timing/type: Y0 and z are
/// combinational outputs; Y0 is next_state[0], while z is the present-state
/// table output.
module TopModule (
  input logic clk,
  input logic x,
  input logic [2:0] y,
  output logic Y0,
  output logic z
);

  logic [2:0] next_y;
  always_comb begin
    unique case (y)
      3'd0: begin
        next_y = x ? 3'd1 : 3'd0;
      end
      3'd1: begin
        next_y = x ? 3'd4 : 3'd1;
      end
      3'd2: begin
        next_y = x ? 3'd1 : 3'd2;
      end
      3'd3: begin
        next_y = x ? 3'd2 : 3'd1;
      end
      3'd4: begin
        next_y = x ? 3'd4 : 3'd3;
      end
      default: begin
        next_y = 3'd0;
      end
    endcase
    unique case (y)
      3'd3: begin
        z = 1'b1;
      end
      3'd4: begin
        z = 1'b1;
      end
      default: begin
        z = 1'b0;
      end
    endcase
    Y0 = next_y[0];
  end

endmodule

