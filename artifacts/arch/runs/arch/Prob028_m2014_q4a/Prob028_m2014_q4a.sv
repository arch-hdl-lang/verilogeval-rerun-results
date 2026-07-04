//! ---
//! spec_md: dataset_spec-to-rtl/Prob028_m2014_q4a_prompt.txt
//! tags: [latch, d_latch, level_sensitive]
//! refs: []
//! ---
//!
//! Implements the VerilogEval Prob028_m2014_q4a design: a one-bit D latch with enable.
//! The output follows d while ena is asserted and otherwise retains its prior value.
/// Top-level one-bit D latch with level-sensitive enable.
module TopModule (
  input logic d,
  input logic ena,
  output logic q
);

  logic latched_q;
  assign q = latched_q;
  always_latch begin
    if (ena) begin
      latched_q = d;
    end
  end

endmodule

