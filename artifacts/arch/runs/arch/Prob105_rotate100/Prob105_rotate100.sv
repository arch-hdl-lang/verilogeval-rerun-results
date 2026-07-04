//! ---
//! spec_md: dataset_spec-to-rtl/Prob105_rotate100_prompt.txt
//! tags: [rotator, shift-register, synchronous-load, sequential]
//! ---
//!
//! Implements the VerilogEval Prob105_rotate100 prompt as a 100-bit synchronous
//! left/right rotator with load priority and hold behavior for disabled modes.
/// Top-level 100-bit rotator preserving the requested TopModule interface.
///
/// On each rising clock edge, load takes priority over rotation; ena selects
/// rotate-right, rotate-left, or hold.
module TopModule (
  input logic clk,
  input logic load,
  input logic [1:0] ena,
  input logic [99:0] data,
  output logic [99:0] q
);

  logic [99:0] rot;
  assign q = rot;
  always_ff @(posedge clk) begin
    if (load) begin
      rot <= data;
    end else if (ena == 2'd1) begin
      rot <= {rot[0], rot[99:1]};
    end else if (ena == 2'd2) begin
      rot <= {rot[98:0], rot[99]};
    end
  end

endmodule

