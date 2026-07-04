//! ---
//! spec_md: dataset_spec-to-rtl/Prob115_shift18_prompt.txt
//! tags: [shift-register, arithmetic-shift, synchronous-load]
//! refs: []
//! ---
//!
//! Implements the Prob115_shift18 prompt: a 64-bit synchronous-load arithmetic
//! shift register controlled by load, enable, and a two-bit shift amount.
/// Top-level 64-bit arithmetic shift register.
///
/// On each rising edge, load has priority over enabled shifts. The current
/// register contents are exposed on q.
module TopModule (
  input logic clk,
  input logic load,
  input logic ena,
  input logic [1:0] amount,
  input logic [63:0] data,
  output logic [63:0] q
);

  logic [63:0] sh;
  assign q = sh;
  always_ff @(posedge clk) begin
    if (load) begin
      sh <= data;
    end else if (ena) begin
      unique case (amount)
        2'd0: begin
          sh <= {sh[62:0], 1'd0};
        end
        2'd1: begin
          sh <= {sh[55:0], 8'd0};
        end
        2'd2: begin
          sh <= {sh[63], sh[63:1]};
        end
        2'd3: begin
          sh <= {sh[63], sh[63], sh[63], sh[63], sh[63], sh[63], sh[63], sh[63], sh[63:8]};
        end
      endcase
    end
  end

endmodule

