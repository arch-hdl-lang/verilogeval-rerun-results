//! ---
//! spec_md: dataset_spec-to-rtl/Prob128_fsm_ps2_prompt.txt
//! tags: [ps2, mouse, byte-stream, fsm]
//! ---
//!
//! PS/2 mouse message boundary detector. The design discards bytes until a
//! first message byte is identified by in[3]=1, then asserts done for one
//! cycle after the third byte has been sampled.
/// Top-level FSM for PS/2 mouse packet framing.
///
/// Port timing/type notes:
/// clk: positive-edge sampling clock.
/// reset: active-high synchronous reset.
/// in: UInt<8> byte sampled on each positive clock edge.
/// done: combinational/state-derived output, high only in state Done.
///
/// Transition table:
/// | input condition | current state | next state | output |
/// | in[3] == 0 | Search | Search | done = 0 |
/// | in[3] == 1 | Search | Byte2 | done = 0 |
/// | any byte | Byte2 | Byte3 | done = 0 |
/// | any byte | Byte3 | Done | done = 0 |
/// | in[3] == 0 | Done | Search | done = 1 |
/// | in[3] == 1 | Done | Byte2 | done = 1 |
module TopModule (
  input logic clk,
  input logic reset,
  input logic [7:0] in,
  output logic done
);

  typedef enum logic [1:0] {
    SEARCH = 2'd0,
    BYTE2 = 2'd1,
    BYTE3 = 2'd2,
    DONE = 2'd3
  } TopModule_state_t;
  
  TopModule_state_t state_r, state_next;
  
  always_ff @(posedge clk) begin
    if (reset) begin
      state_r <= SEARCH;
    end else begin
      state_r <= state_next;
    end
  end
  
  always_comb begin
    state_next = state_r; // hold by default
    unique case (state_r)
      SEARCH: begin
        if (in[3] == 1'd1) state_next = BYTE2;
      end
      BYTE2: begin
        state_next = BYTE3;
      end
      BYTE3: begin
        state_next = DONE;
      end
      DONE: begin
        if (in[3] == 1'd1) state_next = BYTE2;
        else if (in[3] == 1'd0) state_next = SEARCH;
      end
      default: state_next = state_r;
    endcase
  end
  
  always_comb begin
    done = 1'b0;
    unique case (state_r)
      SEARCH: begin
      end
      BYTE2: begin
      end
      BYTE3: begin
      end
      DONE: begin
        done = 1'b1;
      end
      default: ;
    endcase
  end
  
  // synopsys translate_off
  _auto_reach_Search: cover property (@(posedge clk) state_r == SEARCH);
  _auto_reach_Byte2: cover property (@(posedge clk) state_r == BYTE2);
  _auto_reach_Byte3: cover property (@(posedge clk) state_r == BYTE3);
  _auto_reach_Done: cover property (@(posedge clk) state_r == DONE);
  _auto_tr_SEARCH_to_BYTE2: cover property (@(posedge clk) state_r == SEARCH && state_next == BYTE2);
  _auto_tr_BYTE2_to_BYTE3: cover property (@(posedge clk) state_r == BYTE2 && state_next == BYTE3);
  _auto_tr_BYTE3_to_DONE: cover property (@(posedge clk) state_r == BYTE3 && state_next == DONE);
  _auto_tr_DONE_to_BYTE2: cover property (@(posedge clk) state_r == DONE && state_next == BYTE2);
  _auto_tr_DONE_to_SEARCH: cover property (@(posedge clk) state_r == DONE && state_next == SEARCH);
  // synopsys translate_on

endmodule

