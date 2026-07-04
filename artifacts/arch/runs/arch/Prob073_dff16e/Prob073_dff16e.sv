//! ---
//! spec_md: dataset_spec-to-rtl/Prob073_dff16e_prompt.txt
//! tags: [dff, byte-enable, synchronous-reset, register]
//! refs: []
//! ---
//!
//! Implements a 16-bit positive-edge register bank with byte enables.
//! The synchronous active-low reset clears all flip-flops, and disabled bytes retain their current values.
/// Byte-enabled 16-bit D flip-flop bank.
///
/// `q` reflects a register updated on the rising edge of `clk`; `byteena[1]`
/// controls the upper byte and `byteena[0]` controls the lower byte.
module TopModule (
  input logic clk,
  input logic resetn,
  input logic [1:0] byteena,
  input logic [15:0] d,
  output logic [15:0] q
);

  logic [15:0] stored_q;
  assign q = stored_q;
  always_ff @(posedge clk) begin
    if ((!resetn)) begin
      stored_q <= 0;
    end else begin
      if (byteena[1] && byteena[0]) begin
        stored_q <= d;
      end else if (byteena[1]) begin
        stored_q <= {d[15:8], stored_q[7:0]};
      end else if (byteena[0]) begin
        stored_q <= {stored_q[15:8], d[7:0]};
      end else begin
        stored_q <= stored_q;
      end
    end
  end

endmodule

