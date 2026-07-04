//! ---
//! spec_md: dataset_spec-to-rtl/Prob126_circuit6_prompt.txt
//! tags: [combinational, lookup, waveform, constant-map]
//! refs: []
//! ---
//!
//! Implements the waveform-derived combinational mapping from a 3-bit input
//! to one of eight 16-bit constants.
/// Top-level combinational lookup circuit for Prob126_circuit6.
///
/// The 3-bit input `a` selects the exact 16-bit value shown in the prompt
/// waveform table; `q` has no clocked latency.
module TopModule (
  input logic [2:0] a,
  output logic [15:0] q
);

  always_comb begin
    unique case (a)
      3'd0: begin
        q = 16'd4658;
      end
      3'd1: begin
        q = 16'd44768;
      end
      3'd2: begin
        q = 16'd10196;
      end
      3'd3: begin
        q = 16'd23054;
      end
      3'd4: begin
        q = 16'd8294;
      end
      3'd5: begin
        q = 16'd25806;
      end
      3'd6: begin
        q = 16'd50470;
      end
      3'd7: begin
        q = 16'd12057;
      end
    endcase
  end

endmodule

