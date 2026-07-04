//! ---
//! spec_md: dataset_spec-to-rtl/Prob045_edgedetect2_prompt.txt
//! tags: [edge-detect, vector, registered, sequential]
//! refs: []
//! ---
//!
//! Eight-bit any-edge detector. The design samples the input on each rising
//! clock edge and reports which bits changed compared with the previous sample.
/// Top-level eight-bit any-edge detector.
///
/// For each bit, anyedge is asserted one cycle after the sampled input differs
/// from the previous sampled value.
module TopModule (
  input logic clk,
  input logic [7:0] in,
  output logic [7:0] anyedge
);

  logic [7:0] prev_in;
  always_ff @(posedge clk) begin
    anyedge <= in ^ prev_in;
    prev_in <= in;
  end

endmodule

