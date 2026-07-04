//! ---
//! spec_md: dataset_spec-to-rtl/Prob139_2013_q2bfsm_prompt.txt
//! tags: [fsm, motor-control, sequence-detect, synchronous-reset]
//! ---
//!
//! Motor-control FSM for Prob139_2013_q2bfsm. The controller emits a one-cycle
//! f pulse after synchronous active-low reset releases, then detects x=1,0,1
//! and decides whether g remains asserted based on y over the next two cycles.
///
/// Top-level motor-control finite state machine.
///
/// Port timing/type notes:
/// - clk: positive-edge clock.
/// - resetn: synchronous active-low reset; while asserted, state is A.
/// - x, y: sampled on the positive edge of clk.
/// - f, g: combinational, state-derived outputs visible from the current state.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | any, resetn asserted | any | A | f=0, g=0 |
/// | resetn deasserted | A | B | f=0, g=0 |
/// | any | B | C | f=1, g=0 |
/// | x == 1 | C | D | f=0, g=0 |
/// | x == 0 | C | C | f=0, g=0 |
/// | x == 0 | D | E | f=0, g=0 |
/// | x == 1 | D | D | f=0, g=0 |
/// | x == 1 | E | F | f=0, g=0 |
/// | x == 0 | E | C | f=0, g=0 |
/// | y == 1 | F | G | f=0, g=1 |
/// | y == 0 | F | H | f=0, g=1 |
/// | y == 1 | H | G | f=0, g=1 |
/// | y == 0 | H | I | f=0, g=1 |
/// | any | G | G | f=0, g=1 |
/// | any | I | I | f=0, g=0 |
module TopModule (
  input logic clk,
  input logic resetn,
  input logic x,
  input logic y,
  output logic f,
  output logic g
);

  logic [3:0] state_r;
  assign f = state_r == 4'd1;
  assign g = state_r == 4'd5 || state_r == 4'd6 || state_r == 4'd7;
  always_ff @(posedge clk) begin
    if ((!resetn)) begin
      state_r <= 0;
    end else begin
      if (state_r == 4'd0) begin
        state_r <= 4'd1;
      end else if (state_r == 4'd1) begin
        state_r <= 4'd2;
      end else if (state_r == 4'd2) begin
        if (x) begin
          state_r <= 4'd3;
        end else begin
          state_r <= 4'd2;
        end
      end else if (state_r == 4'd3) begin
        if (x) begin
          state_r <= 4'd3;
        end else begin
          state_r <= 4'd4;
        end
      end else if (state_r == 4'd4) begin
        if (x) begin
          state_r <= 4'd5;
        end else begin
          state_r <= 4'd2;
        end
      end else if (state_r == 4'd5) begin
        if (y) begin
          state_r <= 4'd6;
        end else begin
          state_r <= 4'd7;
        end
      end else if (state_r == 4'd7) begin
        if (y) begin
          state_r <= 4'd6;
        end else begin
          state_r <= 4'd8;
        end
      end else if (state_r == 4'd6) begin
        state_r <= 4'd6;
      end else begin
        state_r <= 4'd8;
      end
    end
  end

endmodule

