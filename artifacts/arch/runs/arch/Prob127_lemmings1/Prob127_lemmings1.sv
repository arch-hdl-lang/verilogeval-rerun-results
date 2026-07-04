//! ---
//! spec_md: dataset_spec-to-rtl/Prob127_lemmings1_prompt.txt
//! tags: [fsm, lemmings, moore, async_reset]
//! ---
//!
//! Two-state Moore controller for the Lemmings walking-direction problem.
//! The asynchronous active-high reset initializes the controller to walking left.
/// Top-level Lemmings direction finite-state machine.
///
/// Port timing/type notes:
/// - clk: positive-edge clock for state updates.
/// - areset: positive-edge asynchronous active-high reset to WalkLeft.
/// - bump_left, bump_right: sampled by the FSM transition logic for the next state.
/// - walk_left, walk_right: combinational Moore outputs derived from the current state.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | bump_left == 1 | WalkLeft | WalkRight | walk_left=1, walk_right=0 while in WalkLeft |
/// | bump_left == 0 | WalkLeft | WalkLeft | walk_left=1, walk_right=0 while in WalkLeft |
/// | bump_right == 1 | WalkRight | WalkLeft | walk_left=0, walk_right=1 while in WalkRight |
/// | bump_right == 0 | WalkRight | WalkRight | walk_left=0, walk_right=1 while in WalkRight |
module TopModule (
  input logic clk,
  input logic areset,
  input logic bump_left,
  input logic bump_right,
  output logic walk_left,
  output logic walk_right
);

  typedef enum logic [0:0] {
    WALKLEFT = 1'd0,
    WALKRIGHT = 1'd1
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
        if (bump_left) state_next = WALKRIGHT;
      end
      WALKRIGHT: begin
        if (bump_right) state_next = WALKLEFT;
      end
      default: state_next = state_r;
    endcase
  end
  
  always_comb begin
    walk_left = 1'b0;
    walk_right = 1'b0;
    unique case (state_r)
      WALKLEFT: begin
        walk_left = 1'b1;
      end
      WALKRIGHT: begin
        walk_right = 1'b1;
      end
      default: ;
    endcase
  end
  
  // synopsys translate_off
  _auto_reach_WalkLeft: cover property (@(posedge clk) state_r == WALKLEFT);
  _auto_reach_WalkRight: cover property (@(posedge clk) state_r == WALKRIGHT);
  _auto_tr_WALKLEFT_to_WALKRIGHT: cover property (@(posedge clk) state_r == WALKLEFT && state_next == WALKRIGHT);
  _auto_tr_WALKRIGHT_to_WALKLEFT: cover property (@(posedge clk) state_r == WALKRIGHT && state_next == WALKLEFT);
  // synopsys translate_on

endmodule

