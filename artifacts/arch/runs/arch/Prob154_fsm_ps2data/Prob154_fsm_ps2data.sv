//! ---
//! spec_md: dataset_spec-to-rtl/Prob154_fsm_ps2data_prompt.txt
//! tags: [fsm, byte-stream, packet-parser, ps2data]
//! refs: []
//! ---
//!
//! Implements the requested byte-stream boundary detector. Bytes are ignored
//! until bit 3 of an input byte is set; that byte and the next two bytes form a
//! 24-bit packet reported by registered outputs on the following clock.
/// Top-level byte-stream finite state machine for Prob154_fsm_ps2data.
///
/// Port timing/type notes:
/// input clk: positive-edge sampling clock.
/// input reset: active-high synchronous reset.
/// input in: UInt<8>, sampled on each rising edge when reset is low.
/// output done: pipe_reg<Bool, 1>, asserted one cycle after byte 3 is sampled.
/// output out_bytes: pipe_reg<UInt<24>, 1>, valid whenever done is asserted.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | reset asserted | any | Search | done@1 = 0, out_bytes@1 = 0 by reset |
/// | in[3] == 0 | Search | Search | done@1 = 0 |
/// | in[3] == 1 | Search | GotFirst | done@1 = 0; capture byte 1 = in |
/// | any byte | GotFirst | GotSecond | done@1 = 0; capture byte 2 = in |
/// | any byte | GotSecond | Search | done@1 = 1 next cycle; out_bytes@1 = {byte1, byte2, in} next cycle |
module TopModule (
  input logic clk,
  input logic reset,
  input logic [7:0] in,
  output logic [23:0] out_bytes,
  output logic done
);

  logic [1:0] parse_state;
  logic [7:0] first_byte;
  logic [7:0] second_byte;
  always_ff @(posedge clk) begin
    if (reset) begin
      done <= 1'b0;
      first_byte <= 0;
      out_bytes <= 0;
      parse_state <= 0;
      second_byte <= 0;
    end else begin
      if (parse_state == 2'd0) begin
        done <= 1'b0;
        if (in[3]) begin
          first_byte <= in;
          parse_state <= 2'd1;
        end
      end else if (parse_state == 2'd1) begin
        done <= 1'b0;
        second_byte <= in;
        parse_state <= 2'd2;
      end else if (parse_state == 2'd2) begin
        done <= 1'b1;
        out_bytes <= {first_byte, second_byte, in};
        parse_state <= 2'd0;
      end else begin
        done <= 1'b0;
        parse_state <= 2'd0;
      end
    end
  end

endmodule

