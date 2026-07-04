//! ---
//! spec_md: dataset_spec-to-rtl/Prob140_fsm_hdlc_prompt.txt
//! tags: [hdlc, framing, serial, fsm]
//! ---
//!
//! Moore-style HDLC framing marker decoder. The design tracks consecutive one
//! bits after a zero and emits one-cycle state-derived indications for
//! stuffed-zero discard, frame flag, and 7-or-more-ones error conditions.
/// Top-level HDLC bit-stream recognizer preserving the requested interface.
///
/// Port timing/type:
/// input clk: positive-edge sampling clock.
/// input reset: active-high synchronous reset; reset state behaves as previous input 0.
/// input in: sampled on each positive clock edge.
/// output disc: combinational/state-derived Moore output, asserted in state Disc.
/// output flag: combinational/state-derived Moore output, asserted in state Flag.
/// output err: combinational/state-derived Moore output, asserted in state Err.
///
/// Transition table:
/// | input condition | current state | next state | output visible in current state |
/// | in == 0 | Zero | Zero | disc=0 flag=0 err=0 |
/// | in == 1 | Zero | One | disc=0 flag=0 err=0 |
/// | in == 0 | One | Zero | disc=0 flag=0 err=0 |
/// | in == 1 | One | Two | disc=0 flag=0 err=0 |
/// | in == 0 | Two | Zero | disc=0 flag=0 err=0 |
/// | in == 1 | Two | Three | disc=0 flag=0 err=0 |
/// | in == 0 | Three | Zero | disc=0 flag=0 err=0 |
/// | in == 1 | Three | Four | disc=0 flag=0 err=0 |
/// | in == 0 | Four | Zero | disc=0 flag=0 err=0 |
/// | in == 1 | Four | Five | disc=0 flag=0 err=0 |
/// | in == 0 | Five | Disc | disc=0 flag=0 err=0; Disc is visible after this edge for 0111110 |
/// | in == 1 | Five | Six | disc=0 flag=0 err=0 |
/// | in == 0 | Six | Flag | disc=0 flag=0 err=0; Flag is visible after this edge for 01111110 |
/// | in == 1 | Six | Err | disc=0 flag=0 err=0; Err is visible after this edge for 7 ones |
/// | in == 0 | Disc | Zero | disc=1 flag=0 err=0 |
/// | in == 1 | Disc | One | disc=1 flag=0 err=0 |
/// | in == 0 | Flag | Zero | disc=0 flag=1 err=0 |
/// | in == 1 | Flag | One | disc=0 flag=1 err=0 |
/// | in == 0 | Err | Zero | disc=0 flag=0 err=1 |
/// | in == 1 | Err | Err | disc=0 flag=0 err=1 |
module TopModule (
  input logic clk,
  input logic reset,
  input logic in,
  output logic disc,
  output logic flag,
  output logic err
);

  logic [3:0] state_r;
  always_comb begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    if (state_r == 4'd7) begin
      disc = 1'b1;
    end else if (state_r == 4'd8) begin
      flag = 1'b1;
    end else if (state_r == 4'd9) begin
      err = 1'b1;
    end
  end
  always_ff @(posedge clk) begin
    if (reset) begin
      state_r <= 4'd0;
    end else begin
      if (state_r == 4'd0) begin
        if (in) begin
          state_r <= 4'd1;
        end else begin
          state_r <= 4'd0;
        end
      end else if (state_r == 4'd1) begin
        if (in) begin
          state_r <= 4'd2;
        end else begin
          state_r <= 4'd0;
        end
      end else if (state_r == 4'd2) begin
        if (in) begin
          state_r <= 4'd3;
        end else begin
          state_r <= 4'd0;
        end
      end else if (state_r == 4'd3) begin
        if (in) begin
          state_r <= 4'd4;
        end else begin
          state_r <= 4'd0;
        end
      end else if (state_r == 4'd4) begin
        if (in) begin
          state_r <= 4'd5;
        end else begin
          state_r <= 4'd0;
        end
      end else if (state_r == 4'd5) begin
        if (in) begin
          state_r <= 4'd6;
        end else begin
          state_r <= 4'd7;
        end
      end else if (state_r == 4'd6) begin
        if (in) begin
          state_r <= 4'd9;
        end else begin
          state_r <= 4'd8;
        end
      end else if (state_r == 4'd7) begin
        if (in) begin
          state_r <= 4'd1;
        end else begin
          state_r <= 4'd0;
        end
      end else if (state_r == 4'd8) begin
        if (in) begin
          state_r <= 4'd1;
        end else begin
          state_r <= 4'd0;
        end
      end else if (in) begin
        state_r <= 4'd9;
      end else begin
        state_r <= 4'd0;
      end
    end
  end

endmodule

