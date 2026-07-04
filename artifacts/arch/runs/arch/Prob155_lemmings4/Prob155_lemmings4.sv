//! ---
//! spec_md: dataset_spec-to-rtl/Prob155_lemmings4_prompt.txt
//! tags: [lemmings, fsm, falling, digging, splatter]
//! refs: []
//! ---
//!
//! Moore state machine for the VerilogEval Lemmings problem with walking
//! direction, falling, digging, and permanent splatter after an overlong fall.
/// Top-level Lemming controller preserving the requested VerilogEval interface.
///
/// Inputs are sampled on the positive clock edge, with positive asynchronous
/// reset to WalkLeft. Outputs are combinational and state-derived.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | ground == 0 | WalkLeft | FallLeft | walk_left=1, walk_right=0, aaah=0, digging=0 |
/// | ground == 1 and dig == 1 | WalkLeft | DigLeft | walk_left=1, walk_right=0, aaah=0, digging=0 |
/// | ground == 1 and dig == 0 and bump_left == 1 | WalkLeft | WalkRight | walk_left=1, walk_right=0, aaah=0, digging=0 |
/// | otherwise | WalkLeft | WalkLeft | walk_left=1, walk_right=0, aaah=0, digging=0 |
/// | ground == 0 | WalkRight | FallRight | walk_left=0, walk_right=1, aaah=0, digging=0 |
/// | ground == 1 and dig == 1 | WalkRight | DigRight | walk_left=0, walk_right=1, aaah=0, digging=0 |
/// | ground == 1 and dig == 0 and bump_right == 1 | WalkRight | WalkLeft | walk_left=0, walk_right=1, aaah=0, digging=0 |
/// | otherwise | WalkRight | WalkRight | walk_left=0, walk_right=1, aaah=0, digging=0 |
/// | ground == 0 | DigLeft | FallLeft | walk_left=0, walk_right=0, aaah=0, digging=1 |
/// | otherwise | DigLeft | DigLeft | walk_left=0, walk_right=0, aaah=0, digging=1 |
/// | ground == 0 | DigRight | FallRight | walk_left=0, walk_right=0, aaah=0, digging=1 |
/// | otherwise | DigRight | DigRight | walk_left=0, walk_right=0, aaah=0, digging=1 |
/// | ground == 1 and fall_ticks > 20 | FallLeft | Splat | walk_left=0, walk_right=0, aaah=1, digging=0 |
/// | ground == 1 and fall_ticks <= 20 | FallLeft | WalkLeft | walk_left=0, walk_right=0, aaah=1, digging=0 |
/// | ground == 0 | FallLeft | FallLeft | walk_left=0, walk_right=0, aaah=1, digging=0 |
/// | ground == 1 and fall_ticks > 20 | FallRight | Splat | walk_left=0, walk_right=0, aaah=1, digging=0 |
/// | ground == 1 and fall_ticks <= 20 | FallRight | WalkRight | walk_left=0, walk_right=0, aaah=1, digging=0 |
/// | ground == 0 | FallRight | FallRight | walk_left=0, walk_right=0, aaah=1, digging=0 |
/// | any | Splat | Splat | walk_left=0, walk_right=0, aaah=0, digging=0 |
module TopModule (
  input logic clk,
  input logic areset,
  input logic bump_left,
  input logic bump_right,
  input logic ground,
  input logic dig,
  output logic walk_left,
  output logic walk_right,
  output logic aaah,
  output logic digging
);

  logic [2:0] state_r;
  logic [4:0] fall_ticks;
  always_comb begin
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;
    digging = 1'b0;
    if (state_r == 3'd0) begin
      walk_left = 1'b1;
    end else if (state_r == 3'd1) begin
      walk_right = 1'b1;
    end else if (state_r == 3'd2) begin
      digging = 1'b1;
    end else if (state_r == 3'd3) begin
      digging = 1'b1;
    end else if (state_r == 3'd4) begin
      aaah = 1'b1;
    end else if (state_r == 3'd5) begin
      aaah = 1'b1;
    end else begin
      walk_left = 1'b0;
    end
  end
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      fall_ticks <= 0;
      state_r <= 0;
    end else begin
      if (state_r == 3'd0) begin
        if (ground == 1'b0) begin
          state_r <= 3'd4;
          fall_ticks <= 1;
        end else if (dig) begin
          state_r <= 3'd2;
          fall_ticks <= 0;
        end else if (bump_left) begin
          state_r <= 3'd1;
          fall_ticks <= 0;
        end else begin
          state_r <= 3'd0;
          fall_ticks <= 0;
        end
      end else if (state_r == 3'd1) begin
        if (ground == 1'b0) begin
          state_r <= 3'd5;
          fall_ticks <= 1;
        end else if (dig) begin
          state_r <= 3'd3;
          fall_ticks <= 0;
        end else if (bump_right) begin
          state_r <= 3'd0;
          fall_ticks <= 0;
        end else begin
          state_r <= 3'd1;
          fall_ticks <= 0;
        end
      end else if (state_r == 3'd2) begin
        if (ground == 1'b0) begin
          state_r <= 3'd4;
          fall_ticks <= 1;
        end else begin
          state_r <= 3'd2;
          fall_ticks <= 0;
        end
      end else if (state_r == 3'd3) begin
        if (ground == 1'b0) begin
          state_r <= 3'd5;
          fall_ticks <= 1;
        end else begin
          state_r <= 3'd3;
          fall_ticks <= 0;
        end
      end else if (state_r == 3'd4) begin
        if (ground) begin
          if (fall_ticks > 20) begin
            state_r <= 3'd6;
          end else begin
            state_r <= 3'd0;
          end
        end else begin
          state_r <= 3'd4;
          if (fall_ticks < 21) begin
            fall_ticks <= (5 > 1 ? 5 : 1)'(fall_ticks + 1);
          end else begin
            fall_ticks <= fall_ticks;
          end
        end
      end else if (state_r == 3'd5) begin
        if (ground) begin
          if (fall_ticks > 20) begin
            state_r <= 3'd6;
          end else begin
            state_r <= 3'd1;
          end
        end else begin
          state_r <= 3'd5;
          if (fall_ticks < 21) begin
            fall_ticks <= (5 > 1 ? 5 : 1)'(fall_ticks + 1);
          end else begin
            fall_ticks <= fall_ticks;
          end
        end
      end else begin
        state_r <= 3'd6;
        fall_ticks <= 0;
      end
    end
  end

endmodule

