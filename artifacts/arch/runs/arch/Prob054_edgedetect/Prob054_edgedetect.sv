//! ---
//! spec_md: dataset_spec-to-rtl/Prob054_edgedetect_prompt.txt
//! tags: [edge-detect, vector, registered-output]
//! refs: []
//! ---
//!
//! Implements the Prob054_edgedetect prompt as an 8-bit positive-edge detector.
//! Each bit is compared with its previous sampled value and the registered output
//! reports 0-to-1 transitions one clock cycle after they are observed.
/// Top-level 8-bit positive-edge detector.
///
/// Samples the input vector on the rising clock edge and stores the previous
/// cycle value to detect per-bit 0-to-1 transitions.
module TopModule (
  input logic clk,
  input logic [7:0] in,
  output logic [7:0] pedge = 0
);

  logic [7:0] edge_now;
  logic [7:0] prev_in = 0;
  assign edge_now = ~prev_in & in;
  always_ff @(posedge clk) begin
    prev_in <= in;
    pedge <= edge_now;
  end

endmodule

