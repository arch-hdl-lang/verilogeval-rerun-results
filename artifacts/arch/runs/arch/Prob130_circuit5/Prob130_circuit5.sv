//! ---
//! spec_md: dataset_spec-to-rtl/Prob130_circuit5_prompt.txt
//! tags: [combinational, mux, waveform, verilog-eval]
//! refs: []
//! ---
//!
//! Implements the waveform-derived combinational selection for Prob130_circuit5.
//! The 4-bit selector c chooses b, e, a, or d for selector values 0 through 3,
//! and produces 4'hf for all other selector values.
/// Waveform-derived combinational TopModule for Prob130_circuit5.
///
/// Interface is preserved exactly from the prompt: five 4-bit inputs and one
/// 4-bit output.
module TopModule (
  input logic [3:0] a,
  input logic [3:0] b,
  input logic [3:0] c,
  input logic [3:0] d,
  input logic [3:0] e,
  output logic [3:0] q
);

  always_comb begin
    unique case (c)
      4'd0: begin
        q = b;
      end
      4'd1: begin
        q = e;
      end
      4'd2: begin
        q = a;
      end
      4'd3: begin
        q = d;
      end
      default: begin
        q = 4'd15;
      end
    endcase
  end

endmodule

