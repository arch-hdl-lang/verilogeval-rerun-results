//! ---
//! spec_md: dataset_spec-to-rtl/Prob123_bugs_addsubz_prompt.txt
//! tags: [adder, subtractor, zero_flag, combinational]
//! refs: []
//! ---
//!
//! Combinational 8-bit adder/subtractor with a zero flag. The zero flag is
//! driven on every input combination from the selected wrapped arithmetic result.
/// Top-level combinational add/subtract datapath.
///
/// Selects addition when do_sub is low and subtraction when do_sub is high,
/// then reports whether the selected 8-bit result is zero.
module TopModule (
  input logic do_sub,
  input logic [7:0] a,
  input logic [7:0] b,
  output logic [7:0] out,
  output logic result_is_zero
);

  logic [7:0] selected_result;
  assign selected_result = do_sub ? 8'(a - b) : 8'(a + b);
  assign out = selected_result;
  assign result_is_zero = selected_result == 8'd0;

endmodule

