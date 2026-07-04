//! ---
//! spec_md: dataset_spec-to-rtl/Prob082_lfsr32_prompt.txt
//! tags: [lfsr, galois, shift-register]
//! refs: []
//! ---
//!
//! Implements the requested 32-bit Galois LFSR. The register shifts right on each
//! positive clock edge, applies taps at bit positions 32, 22, 2, and 1, and
//! synchronously resets to 32'h1.
/// Top-level 32-bit Galois LFSR with the exact VerilogEval interface.
///
/// `q` is a registered output updated on the positive edge of `clk`; active-high
/// synchronous reset initializes it to 32'h1.
module TopModule (
  input logic clk,
  input logic reset,
  output logic [31:0] q
);

  always_ff @(posedge clk) begin
    if (reset) begin
      q <= 32'd1;
    end else begin
      q <= {q[0], q[31:23], q[22] ^ q[0], q[21:3], q[2] ^ q[0], q[1] ^ q[0]};
    end
  end

endmodule

