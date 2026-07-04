//! ---
//! spec_md: dataset_spec-to-rtl/Prob076_always_case_prompt.txt
//! tags: [mux, combinational, case]
//! refs: []
//! ---
//!
//! Implements the Prob076_always_case prompt as a combinational 6-to-1
//! multiplexer with an explicit zero default for out-of-range selections.
/// Top-level combinational multiplexer required by the VerilogEval prompt.
///
/// Selects one of six 4-bit data inputs when sel is 0 through 5; otherwise
/// drives zero.
module TopModule (
  input logic [2:0] sel,
  input logic [3:0] data0,
  input logic [3:0] data1,
  input logic [3:0] data2,
  input logic [3:0] data3,
  input logic [3:0] data4,
  input logic [3:0] data5,
  output logic [3:0] out
);

  always_comb begin
    unique case (sel)
      0: begin
        out = data0;
      end
      1: begin
        out = data1;
      end
      2: begin
        out = data2;
      end
      3: begin
        out = data3;
      end
      4: begin
        out = data4;
      end
      5: begin
        out = data5;
      end
      default: begin
        out = 0;
      end
    endcase
  end

endmodule

