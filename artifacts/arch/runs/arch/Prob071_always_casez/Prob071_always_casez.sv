//! ---
//! spec_md: dataset_spec-to-rtl/Prob071_always_casez_prompt.txt
//! tags: [priority-encoder, combinational, casez, bit-vector]
//! refs: []
//! ---
//!
//! Implements the VerilogEval Prob071_always_casez prompt as a combinational
//! 8-bit priority encoder. The least-significant asserted input bit determines
//! the 3-bit position output, with zero also used for the no-bits-set case.
/// Top-level combinational priority encoder for the requested interface.
///
/// Input `in` is scanned from bit 0 toward bit 7, and `pos` reports the
/// first asserted bit index or 3'd0 when no input bit is asserted.
module TopModule (
  input logic [7:0] in,
  output logic [2:0] pos
);

  always_comb begin
    if (in[0]) begin
      pos = 3'd0;
    end else if (in[1]) begin
      pos = 3'd1;
    end else if (in[2]) begin
      pos = 3'd2;
    end else if (in[3]) begin
      pos = 3'd3;
    end else if (in[4]) begin
      pos = 3'd4;
    end else if (in[5]) begin
      pos = 3'd5;
    end else if (in[6]) begin
      pos = 3'd6;
    end else if (in[7]) begin
      pos = 3'd7;
    end else begin
      pos = 3'd0;
    end
  end

endmodule

