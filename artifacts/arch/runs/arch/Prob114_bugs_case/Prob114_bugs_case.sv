//! ---
//! spec_md: dataset_spec-to-rtl/Prob114_bugs_case_prompt.txt
//! tags: [decode, keyboard, scancode]
//! refs: []
//! ---
//!
//! Combinational keyboard scancode decoder for decimal keys 0 through 9.
//! Recognized 8-bit scancodes produce the corresponding 4-bit key value and
//! assert valid; all other inputs drive both outputs to zero.
/// Top-level combinational decoder preserving the requested VerilogEval
/// interface.
module TopModule (
  input logic [7:0] code,
  output logic [3:0] out,
  output logic valid
);

  logic hit0;
  logic hit1;
  logic hit2;
  logic hit3;
  logic hit4;
  logic hit5;
  logic hit6;
  logic hit7;
  logic hit8;
  logic hit9;
  assign hit0 = code == 8'd69;
  assign hit1 = code == 8'd22;
  assign hit2 = code == 8'd30;
  assign hit3 = code == 8'd38;
  assign hit4 = code == 8'd37;
  assign hit5 = code == 8'd46;
  assign hit6 = code == 8'd54;
  assign hit7 = code == 8'd61;
  assign hit8 = code == 8'd62;
  assign hit9 = code == 8'd70;
  assign valid = hit0 || hit1 || hit2 || hit3 || hit4 || hit5 || hit6 || hit7 || hit8 || hit9;
  assign out = hit1 ? 4'd1 : hit2 ? 4'd2 : hit3 ? 4'd3 : hit4 ? 4'd4 : hit5 ? 4'd5 : hit6 ? 4'd6 : hit7 ? 4'd7 : hit8 ? 4'd8 : hit9 ? 4'd9 : 4'd0;

endmodule

