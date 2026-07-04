//! ---
//! spec_md: dataset_spec-to-rtl/Prob039_always_if_prompt.txt
//! tags: [mux, combinational, procedural-if]
//! refs: []
//! ---
//!
//! Implements the requested one-bit 2-to-1 mux twice: once as a direct continuous-style assignment and once with a procedural conditional.
/// Top-level one-bit mux implementation for the VerilogEval Prob039_always_if interface.
///
/// Selects `b` only when both select inputs are true; otherwise selects `a`.
module TopModule (
  input logic a,
  input logic b,
  input logic sel_b1,
  input logic sel_b2,
  output logic out_assign,
  output logic out_always
);

  logic use_b;
  assign use_b = sel_b1 && sel_b2;
  assign out_assign = use_b ? b : a;
  always_comb begin
    if (use_b) begin
      out_always = b;
    end else begin
      out_always = a;
    end
  end

endmodule

