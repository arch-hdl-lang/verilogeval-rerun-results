//! ---
//! spec_md: dataset_spec-to-rtl/Prob121_2014_q3bfsm_prompt.txt
//! tags: [fsm, moore, synchronous-reset, state-table]
//! ---
//!
//! Implements the requested state-assigned Moore FSM for Prob121_2014_q3bfsm.
//! The reset is synchronous active high and returns the state register to 000.
/// Top-level Moore FSM with the exact requested VerilogEval interface.
///
/// Port timing/type:
/// - clk: positive-edge clock input.
/// - reset: synchronous active-high reset input sampled on clk rising edge.
/// - x: one-bit input sampled by the state transition logic on clk rising edge.
/// - z: combinational/state-derived Moore output visible from the current state.
///
/// Transition table:
/// | input condition | current state | next state | output z |
/// | x=0 | 000 | 000 | 0 |
/// | x=1 | 000 | 001 | 0 |
/// | x=0 | 001 | 001 | 0 |
/// | x=1 | 001 | 100 | 0 |
/// | x=0 | 010 | 010 | 0 |
/// | x=1 | 010 | 001 | 0 |
/// | x=0 | 011 | 001 | 1 |
/// | x=1 | 011 | 010 | 1 |
/// | x=0 | 100 | 011 | 1 |
/// | x=1 | 100 | 100 | 1 |
module TopModule (
  input logic clk,
  input logic reset,
  input logic x,
  output logic z
);

  logic [2:0] y;
  assign z = y == 3'd3 || y == 3'd4;
  always_ff @(posedge clk) begin
    if (reset) begin
      y <= 3'd0;
    end else begin
      if (y == 3'd0) begin
        if (x) begin
          y <= 3'd1;
        end else begin
          y <= 3'd0;
        end
      end else if (y == 3'd1) begin
        if (x) begin
          y <= 3'd4;
        end else begin
          y <= 3'd1;
        end
      end else if (y == 3'd2) begin
        if (x) begin
          y <= 3'd1;
        end else begin
          y <= 3'd2;
        end
      end else if (y == 3'd3) begin
        if (x) begin
          y <= 3'd2;
        end else begin
          y <= 3'd1;
        end
      end else if (y == 3'd4) begin
        if (x) begin
          y <= 3'd4;
        end else begin
          y <= 3'd3;
        end
      end else begin
        y <= 3'd0;
      end
    end
  end

endmodule

