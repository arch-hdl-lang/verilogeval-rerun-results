//! ---
//! spec_md: dataset_spec-to-rtl/Prob097_mux9to1v_prompt.txt
//! tags: [mux, combinational, select]
//! refs: []
//! ---
//!
//! Implements the requested 16-bit wide 9-to-1 multiplexer. Select values 0 through 8 choose inputs a through i; unused select values drive all output bits high.
/// Top-level combinational mux preserving the exact requested VerilogEval interface.
module TopModule (
  input logic [15:0] a,
  input logic [15:0] b,
  input logic [15:0] c,
  input logic [15:0] d,
  input logic [15:0] e,
  input logic [15:0] f,
  input logic [15:0] g,
  input logic [15:0] h,
  input logic [15:0] i,
  input logic [3:0] sel,
  output logic [15:0] out
);

  always_comb begin
    unique case (sel)
      4'd0: begin
        out = a;
      end
      4'd1: begin
        out = b;
      end
      4'd2: begin
        out = c;
      end
      4'd3: begin
        out = d;
      end
      4'd4: begin
        out = e;
      end
      4'd5: begin
        out = f;
      end
      4'd6: begin
        out = g;
      end
      4'd7: begin
        out = h;
      end
      4'd8: begin
        out = i;
      end
      default: begin
        out = 16'd65535;
      end
    endcase
  end

endmodule

