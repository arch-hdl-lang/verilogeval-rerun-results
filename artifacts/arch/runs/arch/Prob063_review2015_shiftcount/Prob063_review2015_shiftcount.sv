//! ---
//! spec_md: dataset_spec-to-rtl/Prob063_review2015_shiftcount_prompt.txt
//! tags: [shift-register, down-counter, sequential]
//! refs: []
//! ---
//!
//! Four-bit positive-edge shift register that can also decrement its stored value.
//! When shift enable is asserted, serial data enters the most-significant bit side.
/// Top-level module for the requested four-bit shift/count register.
///
/// Inputs are sampled on the rising edge of clk. The output q reflects the
/// current contents of the internal register with no extra output pipeline.
module TopModule (
  input logic clk,
  input logic shift_ena,
  input logic count_ena,
  input logic data,
  output logic [3:0] q
);

  logic [3:0] q_state;
  assign q = q_state;
  always_ff @(posedge clk) begin
    if (shift_ena) begin
      q_state <= {data, q_state[3:1]};
    end else if (count_ena) begin
      q_state <= 4'(q_state - 4'd1);
    end
  end

endmodule

