//! ---
//! spec_md: dataset_spec-to-rtl/Prob156_review2015_fancytimer_prompt.txt
//! tags: [serial, timer, fsm, counter]
//! ---
//!
//! Serial pattern-triggered timer. The design detects 1101, captures a 4-bit
//! delay value MSB-first, counts exactly (delay + 1) thousand clock cycles,
//! then asserts done until acknowledged.
/// Top-level serial timer implemented as an explicit phase machine.
///
/// Input timing/type:
/// - clk: positive-edge clock.
/// - reset: active-high synchronous reset to Search0.
/// - data: sampled on the rising edge while searching and reading delay bits.
/// - ack: sampled on the rising edge in Done.
///
/// Output timing/type:
/// - count: combinational/state-derived remaining thousand-count bucket.
/// - counting: combinational/state-derived, asserted only in Count.
/// - done: combinational/state-derived, asserted only in Done.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | data == 1 | Search0 | Search1 | counting=0, done=0, count=don't-care |
/// | data == 0 | Search0 | Search0 | counting=0, done=0, count=don't-care |
/// | data == 1 | Search1 | Search2 | counting=0, done=0, count=don't-care |
/// | data == 0 | Search1 | Search0 | counting=0, done=0, count=don't-care |
/// | data == 0 | Search2 | Search3 | counting=0, done=0, count=don't-care |
/// | data == 1 | Search2 | Search2 | counting=0, done=0, count=don't-care |
/// | data == 1 | Search3 | Read3 | counting=0, done=0, count=don't-care |
/// | data == 0 | Search3 | Search0 | counting=0, done=0, count=don't-care |
/// | any data | Read3 | Read2 | captures delay[3], counting=0, done=0 |
/// | any data | Read2 | Read1 | captures delay[2], counting=0, done=0 |
/// | any data | Read1 | Read0 | captures delay[1], counting=0, done=0 |
/// | any data | Read0 | Count | captures delay[0], loads 999-cycle bucket, counting visible next cycle |
/// | bucket not expired | Count | Count | counting=1, done=0, count=remaining delay bucket |
/// | bucket expired and count != 0 | Count | Count | decrements visible count bucket, reloads 999 cycles |
/// | bucket expired and count == 0 | Count | Done | final zero bucket complete; done visible next cycle |
/// | ack == 0 | Done | Done | counting=0, done=1, count=don't-care |
/// | ack == 1 | Done | Search0 | counting=0, done=1 until next clock edge |
module TopModule (
  input logic clk,
  input logic reset,
  input logic data,
  output logic [3:0] count,
  output logic counting,
  output logic done,
  input logic ack
);

  logic [3:0] phase_r;
  logic [3:0] remaining_r;
  logic [9:0] tick_r;
  assign count = remaining_r;
  assign counting = phase_r == 8;
  assign done = phase_r == 9;
  always_ff @(posedge clk) begin
    if (reset) begin
      phase_r <= 0;
      remaining_r <= 0;
      tick_r <= 0;
    end else begin
      if (phase_r == 0) begin
        remaining_r <= 0;
        tick_r <= 0;
        if (data) begin
          phase_r <= 1;
        end else begin
          phase_r <= 0;
        end
      end else if (phase_r == 1) begin
        if (data) begin
          phase_r <= 2;
        end else begin
          phase_r <= 0;
        end
      end else if (phase_r == 2) begin
        if (data) begin
          phase_r <= 2;
        end else begin
          phase_r <= 3;
        end
      end else if (phase_r == 3) begin
        if (data) begin
          phase_r <= 4;
        end else begin
          phase_r <= 0;
        end
      end else if (phase_r == 4) begin
        remaining_r <= {data, 3'd0};
        phase_r <= 5;
      end else if (phase_r == 5) begin
        remaining_r <= {remaining_r[3], data, 2'd0};
        phase_r <= 6;
      end else if (phase_r == 6) begin
        remaining_r <= {remaining_r[3:2], data, 1'd0};
        phase_r <= 7;
      end else if (phase_r == 7) begin
        remaining_r <= {remaining_r[3:1], data};
        tick_r <= 10'd999;
        phase_r <= 8;
      end else if (phase_r == 8) begin
        if (tick_r == 0) begin
          if (remaining_r == 0) begin
            phase_r <= 9;
          end else begin
            remaining_r <= (4 > 1 ? 4 : 1)'(remaining_r - 1);
            tick_r <= 10'd999;
          end
        end else begin
          tick_r <= (10 > 1 ? 10 : 1)'(tick_r - 1);
        end
      end else if (phase_r == 9) begin
        tick_r <= 0;
        remaining_r <= 0;
        if (ack) begin
          phase_r <= 0;
        end else begin
          phase_r <= 9;
        end
      end else begin
        phase_r <= 0;
        tick_r <= 0;
        remaining_r <= 0;
      end
    end
  end

endmodule

