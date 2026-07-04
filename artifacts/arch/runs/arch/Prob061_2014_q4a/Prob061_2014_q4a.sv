//! ---
//! spec_md: dataset_spec-to-rtl/Prob061_2014_q4a_prompt.txt
//! tags: [shift_register, load_enable, sequential_logic]
//! refs: []
//! ---
//!
//! One stage of a larger shift register. The stage stores one bit, loading R when L is asserted, otherwise shifting in w when E is asserted, and otherwise holding the previous value.
/// One-bit positive-edge shift-register stage with synchronous load priority.
module TopModule (
  input logic clk,
  input logic w,
  input logic R,
  input logic E,
  input logic L,
  output logic Q
);

  logic q_value;
  assign Q = q_value;
  always_ff @(posedge clk) begin
    if (L) begin
      q_value <= R;
    end else if (E) begin
      q_value <= w;
    end else begin
      q_value <= q_value;
    end
  end

endmodule

