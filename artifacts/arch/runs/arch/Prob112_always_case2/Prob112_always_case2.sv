//! ---
//! spec_md: dataset_spec-to-rtl/Prob112_always_case2_prompt.txt
//! tags: [priority-encoder, combinational, case-logic]
//! refs: []
//! ---
//!
//! Four-bit combinational priority encoder for the VerilogEval Prob112_always_case2 prompt.
//! The encoder reports the lowest-index asserted bit and returns zero when the input is zero.
/// Top-level four-bit priority encoder preserving the requested VerilogEval interface.
module TopModule (
  input logic [3:0] in,
  output logic [1:0] pos
);

  always_comb begin
    if (in[0]) begin
      pos = 2'd0;
    end else if (in[1]) begin
      pos = 2'd1;
    end else if (in[2]) begin
      pos = 2'd2;
    end else if (in[3]) begin
      pos = 2'd3;
    end else begin
      pos = 2'd0;
    end
  end

endmodule

