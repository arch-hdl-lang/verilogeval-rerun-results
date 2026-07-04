//! ---
//! spec_md: dataset_spec-to-rtl/Prob135_m2014_q6b_prompt.txt
//! tags: [fsm, next_state_logic, combinational, state_encoding]
//! refs: []
//! ---
//!
//! Implements the requested single next-state bit for the encoded six-state FSM.
//! The top-level interface is preserved as a combinational module with current
//! state input `y`, transition input `w`, and next-state bit output `Y1`.
/// TopModule computes the next value of encoded FSM bit y[1].
///
/// Port timing/type:
/// - y: 3-bit current-state encoding input, sampled combinationally.
/// - w: 1-bit transition input, sampled combinationally.
/// - Y1: combinational output representing next-state bit y[1].
///
/// Transition table:
/// | input condition | current state | next state | output Y1 |
/// | w=0 | A (000) | B (001) | 0 |
/// | w=1 | A (000) | A (000) | 0 |
/// | w=0 | B (001) | C (010) | 1 |
/// | w=1 | B (001) | D (011) | 1 |
/// | w=0 | C (010) | E (100) | 0 |
/// | w=1 | C (010) | D (011) | 1 |
/// | w=0 | D (011) | F (101) | 0 |
/// | w=1 | D (011) | A (000) | 0 |
/// | w=0 | E (100) | E (100) | 0 |
/// | w=1 | E (100) | D (011) | 1 |
/// | w=0 | F (101) | C (010) | 1 |
/// | w=1 | F (101) | D (011) | 1 |
module TopModule (
  input logic [2:0] y,
  input logic w,
  output logic Y1
);

  always_comb begin
    unique case ({y, w})
      4'd0: begin
        Y1 = 1'b0;
      end
      4'd1: begin
        Y1 = 1'b0;
      end
      4'd2: begin
        Y1 = 1'b1;
      end
      4'd3: begin
        Y1 = 1'b1;
      end
      4'd4: begin
        Y1 = 1'b0;
      end
      4'd5: begin
        Y1 = 1'b1;
      end
      4'd6: begin
        Y1 = 1'b0;
      end
      4'd7: begin
        Y1 = 1'b0;
      end
      4'd8: begin
        Y1 = 1'b0;
      end
      4'd9: begin
        Y1 = 1'b1;
      end
      4'd10: begin
        Y1 = 1'b1;
      end
      4'd11: begin
        Y1 = 1'b1;
      end
      default: begin
        Y1 = 1'b0;
      end
    endcase
  end

endmodule

