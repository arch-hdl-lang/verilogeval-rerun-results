//! ---
//! spec_md: dataset_spec-to-rtl/Prob137_fsm_serial_prompt.txt
//! tags: [serial, uart, fsm, receiver]
//! ---
//!
//! Serial byte receiver FSM for a stream with idle-high line level, one low
//! start bit, eight data bits sent least significant bit first, and one high
//! stop bit. The FSM reports a correctly received byte by asserting `done` for
//! one cycle after the stop bit has been sampled high.
/// Top-level serial receiver module implementing the finite-state machine.
///
/// Input timing: `in` is sampled on the rising edge of `clk`; `reset` is
/// active-high synchronous. Output timing: `done` is a combinational
/// state-derived Moore output, high only in the Done state, the cycle after a
/// valid stop bit was sampled.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | --- | --- | --- | --- |
/// | `in == 1` | Idle | Idle | `done = 0` |
/// | `in == 0` start bit | Idle | Data0 | `done = 0` |
/// | any data bit 0 | Data0 | Data1 | `done = 0` |
/// | any data bit 1 | Data1 | Data2 | `done = 0` |
/// | any data bit 2 | Data2 | Data3 | `done = 0` |
/// | any data bit 3 | Data3 | Data4 | `done = 0` |
/// | any data bit 4 | Data4 | Data5 | `done = 0` |
/// | any data bit 5 | Data5 | Data6 | `done = 0` |
/// | any data bit 6 | Data6 | Data7 | `done = 0` |
/// | any data bit 7 | Data7 | Stop | `done = 0` |
/// | `in == 1` valid stop bit | Stop | Done | `done = 0` |
/// | `in == 0` invalid stop bit | Stop | WaitStop | `done = 0` |
/// | `in == 0` still missing stop | WaitStop | WaitStop | `done = 0` |
/// | `in == 1` recovery stop found | WaitStop | Idle | `done = 0` |
/// | `in == 1` idle after byte | Done | Idle | `done = 1` |
/// | `in == 0` immediate next start bit | Done | Data0 | `done = 1` |
module TopModule #(
  localparam [3:0] S_IDLE = 4'd0,
  localparam [3:0] S_DATA0 = 4'd1,
  localparam [3:0] S_DATA1 = 4'd2,
  localparam [3:0] S_DATA2 = 4'd3,
  localparam [3:0] S_DATA3 = 4'd4,
  localparam [3:0] S_DATA4 = 4'd5,
  localparam [3:0] S_DATA5 = 4'd6,
  localparam [3:0] S_DATA6 = 4'd7,
  localparam [3:0] S_DATA7 = 4'd8,
  localparam [3:0] S_STOP = 4'd9,
  localparam [3:0] S_DONE = 4'd10,
  localparam [3:0] S_WAITSTOP = 4'd11
) (
  input logic clk,
  input logic reset,
  input logic in,
  output logic done
);

  logic [3:0] state_r;
  assign done = state_r == S_DONE;
  always_ff @(posedge clk) begin
    if (reset) begin
      state_r <= 0;
    end else begin
      if (state_r == S_IDLE) begin
        if (!in) begin
          state_r <= S_DATA0;
        end
      end else if (state_r == S_DATA0) begin
        state_r <= S_DATA1;
      end else if (state_r == S_DATA1) begin
        state_r <= S_DATA2;
      end else if (state_r == S_DATA2) begin
        state_r <= S_DATA3;
      end else if (state_r == S_DATA3) begin
        state_r <= S_DATA4;
      end else if (state_r == S_DATA4) begin
        state_r <= S_DATA5;
      end else if (state_r == S_DATA5) begin
        state_r <= S_DATA6;
      end else if (state_r == S_DATA6) begin
        state_r <= S_DATA7;
      end else if (state_r == S_DATA7) begin
        state_r <= S_STOP;
      end else if (state_r == S_STOP) begin
        if (in) begin
          state_r <= S_DONE;
        end else begin
          state_r <= S_WAITSTOP;
        end
      end else if (state_r == S_DONE) begin
        if (in) begin
          state_r <= S_IDLE;
        end else begin
          state_r <= S_DATA0;
        end
      end else if (state_r == S_WAITSTOP) begin
        if (in) begin
          state_r <= S_IDLE;
        end
      end else begin
        state_r <= S_IDLE;
      end
    end
  end

endmodule

