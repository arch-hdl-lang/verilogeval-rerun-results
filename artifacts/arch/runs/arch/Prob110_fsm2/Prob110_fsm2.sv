//! ---
//! spec_md: dataset_spec-to-rtl/Prob110_fsm2_prompt.txt
//! tags: [fsm, moore, async-reset]
//! refs: []
//! ---
//!
//! Two-state Moore FSM generated for Prob110_fsm2. The active-high asynchronous reset places the machine in OFF; output `out` is state-derived.
/// Top-level two-state Moore FSM for the requested TopModule interface.
///
/// Port timing/type:
/// - `clk`: sampled on the rising edge for state transitions.
/// - `areset`: active-high asynchronous reset to OFF.
/// - `j`, `k`: one-bit inputs sampled by the FSM transition logic.
/// - `out`: combinational/state-derived Moore output, 0 in OFF and 1 in ON.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | j == 0          | OFF           | OFF        | 0      |
/// | j == 1          | OFF           | ON         | 0      |
/// | k == 0          | ON            | ON         | 1      |
/// | k == 1          | ON            | OFF        | 1      |
module TopModule (
  input logic clk,
  input logic areset,
  input logic j,
  input logic k,
  output logic out
);

  typedef enum logic [0:0] {
    OFF = 1'd0,
    ON = 1'd1
  } TopModule_state_t;
  
  TopModule_state_t state_r, state_next;
  
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      state_r <= OFF;
    end else begin
      state_r <= state_next;
    end
  end
  
  always_comb begin
    state_next = state_r; // hold by default
    unique case (state_r)
      OFF: begin
        if (j) state_next = ON;
      end
      ON: begin
        if (k) state_next = OFF;
      end
      default: state_next = state_r;
    endcase
  end
  
  always_comb begin
    out = 1'b0;
    unique case (state_r)
      OFF: begin
      end
      ON: begin
        out = 1'b1;
      end
      default: ;
    endcase
  end
  
  // synopsys translate_off
  _auto_reach_OFF: cover property (@(posedge clk) state_r == OFF);
  _auto_reach_ON: cover property (@(posedge clk) state_r == ON);
  _auto_tr_OFF_to_ON: cover property (@(posedge clk) state_r == OFF && state_next == ON);
  _auto_tr_ON_to_OFF: cover property (@(posedge clk) state_r == ON && state_next == OFF);
  // synopsys translate_on

endmodule

