//! ---
//! spec_md: dataset_spec-to-rtl/Prob089_ece241_2014_q5a_prompt.txt
//! tags: [fsm, serial, twos-complement, moore]
//! refs: []
//! ---
//!
//! Serial least-significant-bit-first two's complementer. The FSM emits zero
//! until the first one is sampled, emits that one, and then emits the inverted
//! value of each subsequent sampled input bit.
/// Top-level Moore state machine for a serial one-bit two's complement stream.
///
/// Port timing/type notes:
/// - clk: positive-edge clock for all sequential state transitions.
/// - areset: asynchronous active-high reset; reset returns the machine to Search.
/// - x: one-bit serial input sampled on each rising edge while reset is low.
/// - z: combinational/state-derived Moore output visible from the current state.
///
/// Transition table:
/// | input condition | current state | next state | output z |
/// | x == 0 | Search | Search | 0 |
/// | x == 1 | Search | EmitOne | 0 before edge, 1 after transition |
/// | x == 0 | EmitOne | EmitOne | 1 |
/// | x == 1 | EmitOne | EmitZero | 1 before edge, 0 after transition |
/// | x == 0 | EmitZero | EmitOne | 0 before edge, 1 after transition |
/// | x == 1 | EmitZero | EmitZero | 0 |
module TopModule (
  input logic clk,
  input logic areset,
  input logic x,
  output logic z
);

  logic [1:0] mode_r;
  assign z = mode_r == 2'd1;
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      mode_r <= 2'd0;
    end else begin
      if (mode_r == 2'd0) begin
        if (x) begin
          mode_r <= 2'd1;
        end
      end else if (mode_r == 2'd1) begin
        if (x) begin
          mode_r <= 2'd2;
        end
      end else if (!x) begin
        mode_r <= 2'd1;
      end
    end
  end

endmodule

