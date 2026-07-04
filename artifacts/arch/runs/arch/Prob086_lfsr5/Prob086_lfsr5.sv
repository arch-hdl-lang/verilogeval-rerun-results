//! ---
//! spec_md: dataset_spec-to-rtl/Prob086_lfsr5_prompt.txt
//! tags: [lfsr, galois, shift-register, synchronous-reset]
//! refs: []
//! ---
//!
//! Implements the requested 5-bit maximal-length Galois LFSR with taps at
//! positions 5 and 3. The output register resets synchronously high to 1 and
//! advances on each positive clock edge.
/// Top-level 5-bit Galois LFSR for Prob086_lfsr5.
///
/// Port timing: clk is sampled on the positive edge; reset is active-high
/// synchronous; q is the registered LFSR state.
module TopModule (
  input logic clk,
  input logic reset,
  output logic [4:0] q
);

  always_ff @(posedge clk) begin
    if (reset) begin
      q <= 5'd1;
    end else begin
      q <= {q[0], q[4], q[3] ^ q[0], q[2], q[1]};
    end
  end

endmodule

