//! ---
//! spec_md: dataset_spec-to-rtl/Prob007_wire_prompt.txt
//! tags: [wire, combinational, passthrough]
//! ---
//!
//! TopModule implements the prompt's one-bit wire behavior by continuously driving the output from the input.
/// One-bit combinational passthrough module.
///
/// The output is continuously equal to the input with no storage or clocking.
module TopModule (
  input logic in,
  output logic out
);

  assign out = in;

endmodule

