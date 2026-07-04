//! ---
//! spec_md: dataset_spec-to-rtl/Prob113_2012_q1g_prompt.txt
//! tags: [kmap, combinational, truth-table]
//! refs: []
//! ---
//!
//! Implements the requested four-input Karnaugh-map function as explicit
//! truth-table logic for the required TopModule interface.
/// Combinational implementation of the Prob113_2012_q1g K-map.
///
/// Input x is indexed exactly as the prompt labels the map: columns are
/// x[0]x[1] and rows are x[2]x[3]. The output f is true for minterms
/// x[3:0] = 0, 1, 4, 5, 6, 12, 14, and 15.
module TopModule (
  input logic [3:0] x,
  output logic f
);

  always_comb begin
    unique case (x)
      4'd0: begin
        f = 1'b1;
      end
      4'd1: begin
        f = 1'b1;
      end
      4'd4: begin
        f = 1'b1;
      end
      4'd5: begin
        f = 1'b1;
      end
      4'd6: begin
        f = 1'b1;
      end
      4'd12: begin
        f = 1'b1;
      end
      4'd14: begin
        f = 1'b1;
      end
      4'd15: begin
        f = 1'b1;
      end
      default: begin
        f = 1'b0;
      end
    endcase
  end

endmodule

