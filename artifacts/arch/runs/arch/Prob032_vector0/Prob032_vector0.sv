//! ---
//! spec_md: dataset_spec-to-rtl/Prob032_vector0_prompt.txt
//! tags: [vector, combinational, bit_split]
//! ---
//!
//! Implements Prob032_vector0 as a pure combinational vector passthrough and bit splitter.
/// Mirrors the 3-bit input vector and exposes each bit on a separate one-bit output.
module TopModule (
  input logic [2:0] vec,
  output logic [2:0] outv,
  output logic o2,
  output logic o1,
  output logic o0
);

  assign outv = vec;
  assign o2 = vec[2];
  assign o1 = vec[1];
  assign o0 = vec[0];

endmodule

