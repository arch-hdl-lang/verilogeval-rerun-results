//! ---
//! spec_md: dataset_spec-to-rtl/Prob085_shift4_prompt.txt
//! tags: [shift-register, sequential, async-reset, load-enable]
//! refs: []
//! ---
//!
//! Implements the VerilogEval Prob085_shift4 prompt as a four-bit right shift
//! register with asynchronous active-high reset and synchronous load/enable
//! control.
/// Four-bit right shift register with load priority.
///
/// `q` is a registered output reset asynchronously by `areset`. On each
/// positive clock edge, `load` captures `data`; otherwise `ena` shifts the
/// contents right with zero fill at bit 3.
module TopModule (
  input logic clk,
  input logic areset,
  input logic load,
  input logic ena,
  input logic [3:0] data,
  output logic [3:0] q
);

  logic [3:0] q_now;
  assign q_now = q;
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      q <= 0;
    end else begin
      if (load) begin
        q <= data;
      end else if (ena) begin
        q <= {1'd0, q_now[3:1]};
      end
    end
  end

endmodule

