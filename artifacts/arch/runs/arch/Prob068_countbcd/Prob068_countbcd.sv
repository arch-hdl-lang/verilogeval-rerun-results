//! ---
//! spec_md: dataset_spec-to-rtl/Prob068_countbcd_prompt.txt
//! tags: [counter, bcd, synchronous-reset]
//! refs: []
//! ---
//!
//! Four-digit BCD counter with synchronous active-high reset. The low digit
//! increments every cycle, upper digits increment on decimal carry, and ena
//! reports the carry enables for digits 1 through 3.
/// Top-level four-digit BCD counter requested by Prob068_countbcd.
///
/// q is the registered 16-bit BCD count value, with q[3:0] as the ones
/// digit. ena is combinational from the current count and indicates when the
/// tens, hundreds, and thousands digits increment on the next rising edge.
module TopModule (
  input logic clk,
  input logic reset,
  output logic [2:0] ena,
  output logic [15:0] q
);

  logic ones_is_nine;
  logic tens_is_nine;
  logic hundreds_is_nine;
  logic thousands_is_nine;
  logic tens_enable;
  logic hundreds_enable;
  logic thousands_enable;
  logic [3:0] ones_next;
  logic [3:0] tens_next;
  logic [3:0] hundreds_next;
  logic [3:0] thousands_next;
  logic [15:0] q_next;
  assign ones_is_nine = q[3:0] == 4'd9;
  assign tens_is_nine = q[7:4] == 4'd9;
  assign hundreds_is_nine = q[11:8] == 4'd9;
  assign thousands_is_nine = q[15:12] == 4'd9;
  assign tens_enable = ones_is_nine;
  assign hundreds_enable = ones_is_nine && tens_is_nine;
  assign thousands_enable = ones_is_nine && tens_is_nine && hundreds_is_nine;
  assign ena = {thousands_enable, hundreds_enable, tens_enable};
  assign ones_next = ones_is_nine ? 4'd0 : ($bits(q[3:0]) > 4 ? $bits(q[3:0]) : 4)'(q[3:0] + 4'd1);
  assign tens_next = tens_enable ? tens_is_nine ? 4'd0 : ($bits(q[7:4]) > 4 ? $bits(q[7:4]) : 4)'(q[7:4] + 4'd1) : q[7:4];
  assign hundreds_next = hundreds_enable ? hundreds_is_nine ? 4'd0 : ($bits(q[11:8]) > 4 ? $bits(q[11:8]) : 4)'(q[11:8] + 4'd1) : q[11:8];
  assign thousands_next = thousands_enable ? thousands_is_nine ? 4'd0 : ($bits(q[15:12]) > 4 ? $bits(q[15:12]) : 4)'(q[15:12] + 4'd1) : q[15:12];
  assign q_next = {thousands_next, hundreds_next, tens_next, ones_next};
  always_ff @(posedge clk) begin
    if (reset) begin
      q <= 0;
    end else begin
      q <= q_next;
    end
  end

endmodule

