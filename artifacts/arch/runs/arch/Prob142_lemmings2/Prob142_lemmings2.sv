//! ---
//! spec_md: dataset_spec-to-rtl/Prob142_lemmings2_prompt.txt
//! tags: [lemmings, fsm, moore, async-reset]
//! refs: []
//! ---
//!
//! Implements the Prob142_lemmings2 Lemming controller as a Moore FSM.
//! The falling states remember the walking direction from before ground disappeared.
/// Top-level Moore FSM for the Lemming walking/falling behavior.
///
/// Port timing/type notes:
/// - clk: positive-edge clock for all sequential state updates.
/// - areset: positive-edge asynchronous active-high reset to WalkLeft.
/// - bump_left, bump_right, ground: sampled on clk rising when not in asynchronous reset.
/// - walk_left, walk_right, aaah: combinational/state-derived Moore outputs.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | not ground | WalkLeft | FallLeft | walk_left=1, walk_right=0, aaah=0 |
/// | ground and bump_left | WalkLeft | WalkRight | walk_left=1, walk_right=0, aaah=0 |
/// | ground and not bump_left | WalkLeft | WalkLeft | walk_left=1, walk_right=0, aaah=0 |
/// | not ground | WalkRight | FallRight | walk_left=0, walk_right=1, aaah=0 |
/// | ground and bump_right | WalkRight | WalkLeft | walk_left=0, walk_right=1, aaah=0 |
/// | ground and not bump_right | WalkRight | WalkRight | walk_left=0, walk_right=1, aaah=0 |
/// | ground | FallLeft | WalkLeft | walk_left=0, walk_right=0, aaah=1 |
/// | not ground | FallLeft | FallLeft | walk_left=0, walk_right=0, aaah=1 |
/// | ground | FallRight | WalkRight | walk_left=0, walk_right=0, aaah=1 |
/// | not ground | FallRight | FallRight | walk_left=0, walk_right=0, aaah=1 |
module TopModule (
  input logic clk,
  input logic areset,
  input logic bump_left,
  input logic bump_right,
  input logic ground,
  output logic walk_left,
  output logic walk_right,
  output logic aaah
);

  typedef enum logic [1:0] {
    WALKLEFT = 2'd0,
    WALKRIGHT = 2'd1,
    FALLLEFT = 2'd2,
    FALLRIGHT = 2'd3
  } TopModule_state_t;
  
  TopModule_state_t state_r, state_next;
  
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      state_r <= WALKLEFT;
    end else begin
      state_r <= state_next;
    end
  end
  
  always_comb begin
    state_next = state_r; // hold by default
    unique case (state_r)
      WALKLEFT: begin
        if (!ground) state_next = FALLLEFT;
        else if (ground && bump_left) state_next = WALKRIGHT;
      end
      WALKRIGHT: begin
        if (!ground) state_next = FALLRIGHT;
        else if (ground && bump_right) state_next = WALKLEFT;
      end
      FALLLEFT: begin
        if (ground) state_next = WALKLEFT;
      end
      FALLRIGHT: begin
        if (ground) state_next = WALKRIGHT;
      end
      default: state_next = state_r;
    endcase
  end
  
  always_comb begin
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;
    unique case (state_r)
      WALKLEFT: begin
        walk_left = 1'b1;
      end
      WALKRIGHT: begin
        walk_right = 1'b1;
      end
      FALLLEFT: begin
        aaah = 1'b1;
      end
      FALLRIGHT: begin
        aaah = 1'b1;
      end
      default: ;
    endcase
  end
  
  // synopsys translate_off
  _auto_reach_WalkLeft: cover property (@(posedge clk) state_r == WALKLEFT);
  _auto_reach_WalkRight: cover property (@(posedge clk) state_r == WALKRIGHT);
  _auto_reach_FallLeft: cover property (@(posedge clk) state_r == FALLLEFT);
  _auto_reach_FallRight: cover property (@(posedge clk) state_r == FALLRIGHT);
  _auto_tr_WALKLEFT_to_FALLLEFT: cover property (@(posedge clk) state_r == WALKLEFT && state_next == FALLLEFT);
  _auto_tr_WALKLEFT_to_WALKRIGHT: cover property (@(posedge clk) state_r == WALKLEFT && state_next == WALKRIGHT);
  _auto_tr_WALKRIGHT_to_FALLRIGHT: cover property (@(posedge clk) state_r == WALKRIGHT && state_next == FALLRIGHT);
  _auto_tr_WALKRIGHT_to_WALKLEFT: cover property (@(posedge clk) state_r == WALKRIGHT && state_next == WALKLEFT);
  _auto_tr_FALLLEFT_to_WALKLEFT: cover property (@(posedge clk) state_r == FALLLEFT && state_next == WALKLEFT);
  _auto_tr_FALLRIGHT_to_WALKRIGHT: cover property (@(posedge clk) state_r == FALLRIGHT && state_next == WALKRIGHT);
  // synopsys translate_on

endmodule

