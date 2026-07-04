//! ---
//! spec_md: dataset_spec-to-rtl/Prob152_lemmings3_prompt.txt
//! tags: [fsm, lemmings, moore, async-reset]
//! refs: []
//! ---
//!
//! Moore FSM for the Lemmings walking, falling, and digging behavior. The
//! asynchronous active-high reset returns the machine to walking left.
/// Top-level Lemmings controller preserving direction across falling and digging.
///
/// Port timing/type:
/// clk: positive-edge clock input.
/// areset: asynchronous active-high reset input; resets state to WalkLeft.
/// bump_left, bump_right, ground, dig: sampled on clk rising while not in reset.
/// walk_left, walk_right, aaah, digging: combinational Moore outputs derived from current state.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | not ground | WalkLeft | FallLeft | walk_left=1 |
/// | ground and dig | WalkLeft | DigLeft | walk_left=1 |
/// | ground and not dig and bump_left | WalkLeft | WalkRight | walk_left=1 |
/// | ground and not dig and not bump_left | WalkLeft | WalkLeft | walk_left=1 |
/// | not ground | WalkRight | FallRight | walk_right=1 |
/// | ground and dig | WalkRight | DigRight | walk_right=1 |
/// | ground and not dig and bump_right | WalkRight | WalkLeft | walk_right=1 |
/// | ground and not dig and not bump_right | WalkRight | WalkRight | walk_right=1 |
/// | not ground | DigLeft | FallLeft | digging=1 |
/// | ground | DigLeft | DigLeft | digging=1 |
/// | not ground | DigRight | FallRight | digging=1 |
/// | ground | DigRight | DigRight | digging=1 |
/// | ground | FallLeft | WalkLeft | aaah=1 |
/// | not ground | FallLeft | FallLeft | aaah=1 |
/// | ground | FallRight | WalkRight | aaah=1 |
/// | not ground | FallRight | FallRight | aaah=1 |
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
  always_comb begin
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;
    digging = 1'b0;
    if (state_r == 3'd0) begin
      walk_left = 1'b1;
    end else if (state_r == 3'd1) begin
      walk_right = 1'b1;
    end else if (state_r == 3'd2 || state_r == 3'd3) begin
      digging = 1'b1;
    end else begin
      aaah = 1'b1;
    end
  end
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      state_r <= 3'd0;
    end else begin
      if (state_r == 3'd0) begin
        if (!ground) begin
          state_r <= 3'd4;
        end else if (dig) begin
          state_r <= 3'd2;
        end else if (bump_left) begin
          state_r <= 3'd1;
        end else begin
          state_r <= 3'd0;
        end
      end else if (state_r == 3'd1) begin
        if (!ground) begin
          state_r <= 3'd5;
        end else if (dig) begin
          state_r <= 3'd3;
        end else if (bump_right) begin
          state_r <= 3'd0;
        end else begin
          state_r <= 3'd1;
        end
      end else if (state_r == 3'd2) begin
        if (!ground) begin
          state_r <= 3'd4;
        end else begin
          state_r <= 3'd2;
        end
      end else if (state_r == 3'd3) begin
        if (!ground) begin
          state_r <= 3'd5;
        end else begin
          state_r <= 3'd3;
        end
      end else if (state_r == 3'd4) begin
        if (ground) begin
          state_r <= 3'd0;
        end else begin
          state_r <= 3'd4;
        end
      end else if (ground) begin
        state_r <= 3'd1;
      end else begin
        state_r <= 3'd5;
      end
    end
  end

endmodule

