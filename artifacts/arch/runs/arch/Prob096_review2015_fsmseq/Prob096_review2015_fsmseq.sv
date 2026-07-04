//! ---
//! spec_md: dataset_spec-to-rtl/Prob096_review2015_fsmseq_prompt.txt
//! tags: [fsm, sequence-detector, serial-input]
//! ---
//!
//! TopModule searches a one-bit input stream for the sequence 1101. After the
//! sequence is detected, start_shifting remains asserted until the active-high
//! synchronous reset returns the state machine to its initial state.
/// Synchronous state-machine sequence detector for the serial pattern 1101.
///
/// Port timing/type notes:
/// - clk: positive-edge clock for all sequential state updates.
/// - reset: active-high synchronous reset.
/// - data: sampled on the positive edge of clk.
/// - start_shifting: combinational state-derived output, 1 only in Found.
///
/// Transition table:
/// | input condition | current state | next state | output start_shifting |
/// | data == 0       | Idle          | Idle       | 0                     |
/// | data == 1       | Idle          | Seen1      | 0                     |
/// | data == 0       | Seen1         | Idle       | 0                     |
/// | data == 1       | Seen1         | Seen11     | 0                     |
/// | data == 0       | Seen11        | Seen110    | 0                     |
/// | data == 1       | Seen11        | Seen11     | 0                     |
/// | data == 0       | Seen110       | Idle       | 0                     |
/// | data == 1       | Seen110       | Found      | 0                     |
/// | any             | Found         | Found      | 1                     |
module TopModule (
  input logic clk,
  input logic reset,
  input logic data,
  output logic start_shifting
);

  logic [2:0] state_r;
  assign start_shifting = state_r == 3'd4;
  always_ff @(posedge clk) begin
    if (reset) begin
      state_r <= 0;
    end else begin
      if (state_r == 3'd0) begin
        if (data) begin
          state_r <= 3'd1;
        end else begin
          state_r <= 3'd0;
        end
      end else if (state_r == 3'd1) begin
        if (data) begin
          state_r <= 3'd2;
        end else begin
          state_r <= 3'd0;
        end
      end else if (state_r == 3'd2) begin
        if (data) begin
          state_r <= 3'd2;
        end else begin
          state_r <= 3'd3;
        end
      end else if (state_r == 3'd3) begin
        if (data) begin
          state_r <= 3'd4;
        end else begin
          state_r <= 3'd0;
        end
      end else begin
        state_r <= 3'd4;
      end
    end
  end

endmodule

