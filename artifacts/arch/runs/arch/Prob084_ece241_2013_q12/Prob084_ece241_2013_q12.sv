//! ---
//! spec_md: dataset_spec-to-rtl/Prob084_ece241_2013_q12_prompt.txt
//! tags: [shift_register, mux, lut, sequential]
//! refs: []
//! ---
//!
//! Implements an 8-bit serially-loaded lookup table. The shift register captures S into Q[0] when enable is high and Z is a combinational random-access read selected by ABC.
/// Top-level 8x1 shift-register memory and 3-input lookup function.
///
/// Port timing/type notes: clk is the positive-edge sampling clock; enable, S, A, B, and C are sampled/observed as one-bit inputs; Z is a combinational output from the current register contents.
/// Shift/read behavior table:
/// | input condition | current state | next state | output |
/// | enable == 1 | q[7:0] | {old q[6:0], S}; Q[0] receives S | Z = q[{A,B,C}] before the active clock edge |
/// | enable == 0 | q[7:0] | q[7:0] holds | Z = q[{A,B,C}] |
/// Address mapping: ABC 000 -> Q[0], 001 -> Q[1], 010 -> Q[2], 011 -> Q[3], 100 -> Q[4], 101 -> Q[5], 110 -> Q[6], 111 -> Q[7].
module TopModule (
  input logic clk,
  input logic enable,
  input logic S,
  input logic A,
  input logic B,
  input logic C,
  output logic Z
);

  logic [2:0] addr;
  logic [7:0] q;
  assign addr = {A, B, C};
  assign Z = q[addr];
  always_ff @(posedge clk) begin
    if (enable) begin
      q <= {q[6:0], S};
    end
  end

endmodule

