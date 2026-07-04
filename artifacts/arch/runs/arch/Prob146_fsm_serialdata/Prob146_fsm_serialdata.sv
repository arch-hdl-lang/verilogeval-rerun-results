//! ---
//! spec_md: dataset_spec-to-rtl/Prob146_fsm_serialdata_prompt.txt
//! tags: [serial, fsm, uart, receiver]
//! refs: []
//! ---
//!
//! Serial byte receiver for a one-start-bit, eight-data-bit, one-stop-bit protocol.
//! The line idles high, data is sent least-significant bit first, and a framing
//! error waits for a high stop bit before looking for another start bit.
/// Top-level serial receive state machine for Prob146_fsm_serialdata.
///
/// Port timing/type notes:
/// clk is the positive-edge sampling clock. reset is active-high synchronous.
/// in is sampled on each rising edge according to the current state.
/// done is combinational/state-derived and is high for one cycle in Done after a valid stop bit.
/// out_byte is combinational from the internal byte register and is valid when done is high.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | in == 1 | Idle | Idle | done = 0, out_byte don't-care |
/// | in == 0 start bit sampled | Idle | Data0 | done = 0, out_byte don't-care |
/// | data bit 0 sampled | Data0 | Data1 | done = 0, shift sampled bit into byte |
/// | data bit 1 sampled | Data1 | Data2 | done = 0, shift sampled bit into byte |
/// | data bit 2 sampled | Data2 | Data3 | done = 0, shift sampled bit into byte |
/// | data bit 3 sampled | Data3 | Data4 | done = 0, shift sampled bit into byte |
/// | data bit 4 sampled | Data4 | Data5 | done = 0, shift sampled bit into byte |
/// | data bit 5 sampled | Data5 | Data6 | done = 0, shift sampled bit into byte |
/// | data bit 6 sampled | Data6 | Data7 | done = 0, shift sampled bit into byte |
/// | data bit 7 sampled | Data7 | Stop | done = 0, shift sampled bit into byte |
/// | in == 1 stop bit sampled | Stop | Done | done = 0, out_byte = received byte |
/// | in == 0 bad stop bit sampled | Stop | Error | done = 0, out_byte don't-care |
/// | in == 1 idle after completed byte | Done | Idle | done = 1, out_byte = received byte |
/// | in == 0 next start after completed byte | Done | Data0 | done = 1, out_byte = received byte |
/// | in == 0 | Error | Error | done = 0, out_byte don't-care |
/// | in == 1 recovery stop bit found | Error | Idle | done = 0, out_byte don't-care |
module TopModule #(
  localparam [3:0] IDLE = 4'd0,
  localparam [3:0] DATA0 = 4'd1,
  localparam [3:0] DATA1 = 4'd2,
  localparam [3:0] DATA2 = 4'd3,
  localparam [3:0] DATA3 = 4'd4,
  localparam [3:0] DATA4 = 4'd5,
  localparam [3:0] DATA5 = 4'd6,
  localparam [3:0] DATA6 = 4'd7,
  localparam [3:0] DATA7 = 4'd8,
  localparam [3:0] STOP = 4'd9,
  localparam [3:0] DONE = 4'd10,
  localparam [3:0] ERROR = 4'd11
) (
  input logic clk,
  input logic reset,
  input logic in,
  output logic [7:0] out_byte,
  output logic done
);

  logic [3:0] state_r;
  logic [7:0] byte_r;
  assign out_byte = byte_r;
  assign done = state_r == DONE;
  always_ff @(posedge clk) begin
    if (reset) begin
      byte_r <= 0;
      state_r <= 0;
    end else begin
      if (state_r == IDLE) begin
        if (!in) begin
          state_r <= DATA0;
        end
      end else if (state_r == DATA0) begin
        byte_r <= {in, byte_r[7:1]};
        state_r <= DATA1;
      end else if (state_r == DATA1) begin
        byte_r <= {in, byte_r[7:1]};
        state_r <= DATA2;
      end else if (state_r == DATA2) begin
        byte_r <= {in, byte_r[7:1]};
        state_r <= DATA3;
      end else if (state_r == DATA3) begin
        byte_r <= {in, byte_r[7:1]};
        state_r <= DATA4;
      end else if (state_r == DATA4) begin
        byte_r <= {in, byte_r[7:1]};
        state_r <= DATA5;
      end else if (state_r == DATA5) begin
        byte_r <= {in, byte_r[7:1]};
        state_r <= DATA6;
      end else if (state_r == DATA6) begin
        byte_r <= {in, byte_r[7:1]};
        state_r <= DATA7;
      end else if (state_r == DATA7) begin
        byte_r <= {in, byte_r[7:1]};
        state_r <= STOP;
      end else if (state_r == STOP) begin
        if (in) begin
          state_r <= DONE;
        end else begin
          state_r <= ERROR;
        end
      end else if (state_r == DONE) begin
        if (in) begin
          state_r <= IDLE;
        end else begin
          state_r <= DATA0;
        end
      end else if (state_r == ERROR) begin
        if (in) begin
          state_r <= IDLE;
        end
      end else begin
        state_r <= IDLE;
      end
    end
  end

endmodule

