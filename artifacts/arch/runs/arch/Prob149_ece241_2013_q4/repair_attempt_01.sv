//! ---
//! spec_md: dataset_spec-to-rtl/Prob149_ece241_2013_q4_prompt.txt
//! tags: [fsm, water-level, flow-control]
//! refs: []
//! ---
//!
//! Water reservoir flow controller derived from the VerilogEval prompt.
//! The controller tracks the sampled sensor-defined water level and whether
//! the latest sensor change indicates a falling level that needs supplemental flow.
/// Top-level water reservoir controller.
///
/// Input timing/type: `clk` is the positive-edge system clock, `reset` is
/// active-high synchronous reset, and `s` is sampled on `clk`. Output
/// timing/type: `fr2`, `fr1`, `fr0`, and `dfr` are combinational
/// state-derived outputs visible for the current sampled level.
///
/// Transition table:
/// input condition | current state | next state | output visible in current state
/// reset asserted | any | Low | fr2=1, fr1=1, fr0=1, dfr=1 after reset state is entered
/// s == 3'b000 | Low | Low | fr2=1, fr1=1, fr0=1, dfr=1
/// s == 3'b001 | Low | MidLowRise | fr2=1, fr1=1, fr0=1, dfr=1
/// s == 3'b011 | Low | MidHighRise | fr2=1, fr1=1, fr0=1, dfr=1
/// s == 3'b111 | Low | High | fr2=1, fr1=1, fr0=1, dfr=1
/// s == 3'b000 | MidLowRise | Low | fr2=0, fr1=1, fr0=1, dfr=0
/// s == 3'b001 | MidLowRise | MidLowRise | fr2=0, fr1=1, fr0=1, dfr=0
/// s == 3'b011 | MidLowRise | MidHighRise | fr2=0, fr1=1, fr0=1, dfr=0
/// s == 3'b111 | MidLowRise | High | fr2=0, fr1=1, fr0=1, dfr=0
/// s == 3'b000 | MidLowFall | Low | fr2=0, fr1=1, fr0=1, dfr=1
/// s == 3'b001 | MidLowFall | MidLowFall | fr2=0, fr1=1, fr0=1, dfr=1
/// s == 3'b011 | MidLowFall | MidHighRise | fr2=0, fr1=1, fr0=1, dfr=1
/// s == 3'b111 | MidLowFall | High | fr2=0, fr1=1, fr0=1, dfr=1
/// s == 3'b000 | MidHighRise | Low | fr2=0, fr1=0, fr0=1, dfr=0
/// s == 3'b001 | MidHighRise | MidLowFall | fr2=0, fr1=0, fr0=1, dfr=0
/// s == 3'b011 | MidHighRise | MidHighRise | fr2=0, fr1=0, fr0=1, dfr=0
/// s == 3'b111 | MidHighRise | High | fr2=0, fr1=0, fr0=1, dfr=0
/// s == 3'b000 | MidHighFall | Low | fr2=0, fr1=0, fr0=1, dfr=1
/// s == 3'b001 | MidHighFall | MidLowFall | fr2=0, fr1=0, fr0=1, dfr=1
/// s == 3'b011 | MidHighFall | MidHighFall | fr2=0, fr1=0, fr0=1, dfr=1
/// s == 3'b111 | MidHighFall | High | fr2=0, fr1=0, fr0=1, dfr=1
/// s == 3'b000 | High | Low | fr2=0, fr1=0, fr0=0, dfr=0
/// s == 3'b001 | High | MidLowFall | fr2=0, fr1=0, fr0=0, dfr=0
/// s == 3'b011 | High | MidHighFall | fr2=0, fr1=0, fr0=0, dfr=0
/// s == 3'b111 | High | High | fr2=0, fr1=0, fr0=0, dfr=0
module TopModule #(
  localparam [2:0] LOW = 3'd0,
  localparam [2:0] MID_LOW_RISE = 3'd1,
  localparam [2:0] MID_LOW_FALL = 3'd2,
  localparam [2:0] MID_HIGH_RISE = 3'd3,
  localparam [2:0] MID_HIGH_FALL = 3'd4,
  localparam [2:0] HIGH_LEVEL = 3'd5
) (
  input logic clk,
  input logic reset,
  input logic [2:0] s,
  output logic fr2,
  output logic fr1,
  output logic fr0,
  output logic dfr
);

  logic [2:0] level_r;
  always_comb begin
    fr2 = 1'b0;
    fr1 = 1'b0;
    fr0 = 1'b0;
    dfr = 1'b0;
    if (level_r == LOW) begin
      fr2 = 1'b1;
      fr1 = 1'b1;
      fr0 = 1'b1;
      dfr = 1'b1;
    end else if (level_r == MID_LOW_RISE) begin
      fr1 = 1'b1;
      fr0 = 1'b1;
    end else if (level_r == MID_LOW_FALL) begin
      fr1 = 1'b1;
      fr0 = 1'b1;
      dfr = 1'b1;
    end else if (level_r == MID_HIGH_RISE) begin
      fr0 = 1'b1;
    end else if (level_r == MID_HIGH_FALL) begin
      fr0 = 1'b1;
      dfr = 1'b1;
    end
  end
  always_ff @(posedge clk) begin
    if (reset) begin
      level_r <= LOW;
    end else begin
      if (level_r == LOW) begin
        if (s == 3'd7) begin
          level_r <= HIGH_LEVEL;
        end else if (s == 3'd3) begin
          level_r <= MID_HIGH_RISE;
        end else if (s == 3'd1) begin
          level_r <= MID_LOW_RISE;
        end
      end else if (level_r == MID_LOW_RISE) begin
        if (s == 3'd7) begin
          level_r <= HIGH_LEVEL;
        end else if (s == 3'd3) begin
          level_r <= MID_HIGH_RISE;
        end else if (s == 3'd0) begin
          level_r <= LOW;
        end
      end else if (level_r == MID_LOW_FALL) begin
        if (s == 3'd7) begin
          level_r <= HIGH_LEVEL;
        end else if (s == 3'd3) begin
          level_r <= MID_HIGH_RISE;
        end else if (s == 3'd0) begin
          level_r <= LOW;
        end
      end else if (level_r == MID_HIGH_RISE) begin
        if (s == 3'd7) begin
          level_r <= HIGH_LEVEL;
        end else if (s == 3'd1) begin
          level_r <= MID_LOW_FALL;
        end else if (s == 3'd0) begin
          level_r <= LOW;
        end
      end else if (level_r == MID_HIGH_FALL) begin
        if (s == 3'd7) begin
          level_r <= HIGH_LEVEL;
        end else if (s == 3'd1) begin
          level_r <= MID_LOW_FALL;
        end else if (s == 3'd0) begin
          level_r <= LOW;
        end
      end else if (s == 3'd3) begin
        level_r <= MID_HIGH_FALL;
      end else if (s == 3'd1) begin
        level_r <= MID_LOW_FALL;
      end else if (s == 3'd0) begin
        level_r <= LOW;
      end
    end
  end

endmodule

