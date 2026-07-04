//! ---
//! spec_md: dataset_spec-to-rtl/Prob151_review2015_fsm_prompt.txt
//! tags: [fsm, timer, sequence-detect, moore-control]
//! ---
//!
//! Finite-state controller for a serially-started timer. The FSM detects the
//! 1101 start sequence, enables four duration-bit shifts, waits for the counter
//! datapath to finish, and holds done until acknowledged.
/// Top-level timer-control finite-state machine.
///
/// Port timing/type notes:
/// - clk: positive-edge sequential clock.
/// - reset: active-high synchronous reset to Search.
/// - data, done_counting, ack: sampled on the rising edge of clk.
/// - shift_ena, counting, done: combinational/state-derived Moore outputs.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | data=0 | Search | Search | shift_ena=0 counting=0 done=0 |
/// | data=1 | Search | Seen1 | shift_ena=0 counting=0 done=0 |
/// | data=0 | Seen1 | Search | shift_ena=0 counting=0 done=0 |
/// | data=1 | Seen1 | Seen11 | shift_ena=0 counting=0 done=0 |
/// | data=0 | Seen11 | Seen110 | shift_ena=0 counting=0 done=0 |
/// | data=1 | Seen11 | Seen11 | shift_ena=0 counting=0 done=0 |
/// | data=0 | Seen110 | Search | shift_ena=0 counting=0 done=0 |
/// | data=1 | Seen110 | Shift0 | shift_ena=0 counting=0 done=0 |
/// | any | Shift0 | Shift1 | shift_ena=1 counting=0 done=0 |
/// | any | Shift1 | Shift2 | shift_ena=1 counting=0 done=0 |
/// | any | Shift2 | Shift3 | shift_ena=1 counting=0 done=0 |
/// | any | Shift3 | Count | shift_ena=1 counting=0 done=0 |
/// | done_counting=0 | Count | Count | shift_ena=0 counting=1 done=0 |
/// | done_counting=1 | Count | Done | shift_ena=0 counting=1 done=0 |
/// | ack=0 | Done | Done | shift_ena=0 counting=0 done=1 |
/// | ack=1 | Done | Search | shift_ena=0 counting=0 done=1 |
module TopModule (
  input logic clk,
  input logic reset,
  input logic data,
  input logic done_counting,
  input logic ack,
  output logic shift_ena,
  output logic counting,
  output logic done
);

  logic [3:0] state_r;
  assign shift_ena = state_r == 4'd4 || state_r == 4'd5 || state_r == 4'd6 || state_r == 4'd7;
  assign counting = state_r == 4'd8;
  assign done = state_r == 4'd9;
  always_ff @(posedge clk) begin
    if (reset) begin
      state_r <= 0;
    end else begin
      if (state_r == 4'd0) begin
        if (data) begin
          state_r <= 4'd1;
        end
      end else if (state_r == 4'd1) begin
        if (data) begin
          state_r <= 4'd2;
        end else begin
          state_r <= 4'd0;
        end
      end else if (state_r == 4'd2) begin
        if (data) begin
          state_r <= 4'd2;
        end else begin
          state_r <= 4'd3;
        end
      end else if (state_r == 4'd3) begin
        if (data) begin
          state_r <= 4'd4;
        end else begin
          state_r <= 4'd0;
        end
      end else if (state_r == 4'd4) begin
        state_r <= 4'd5;
      end else if (state_r == 4'd5) begin
        state_r <= 4'd6;
      end else if (state_r == 4'd6) begin
        state_r <= 4'd7;
      end else if (state_r == 4'd7) begin
        state_r <= 4'd8;
      end else if (state_r == 4'd8) begin
        if (done_counting) begin
          state_r <= 4'd9;
        end
      end else if (state_r == 4'd9) begin
        if (ack) begin
          state_r <= 4'd0;
        end
      end else begin
        state_r <= 4'd0;
      end
    end
  end

endmodule

