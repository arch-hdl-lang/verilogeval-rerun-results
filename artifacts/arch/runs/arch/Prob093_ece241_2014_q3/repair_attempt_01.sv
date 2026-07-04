//! ---
//! spec_md: dataset_spec-to-rtl/Prob093_ece241_2014_q3_prompt.txt
//! tags: [kmap, multiplexer, combinational]
//! refs: []
//! ---
//!
//! Implements mux data-input generation for the VerilogEval ECE241 K-map problem.
//! The output vector drives an external 4-to-1 mux selected by {a,b}; mux_in[0]
//! through mux_in[3] correspond to binary select values 00, 01, 10, and 11.
///
/// Combinational TopModule for deriving the four external 4-to-1 mux data inputs.
///
/// Standard mapping table:
/// input condition | current column | next column | output
/// c=0,d=0 | ab=00 | none | mux_in[0]=0
/// c=0,d=1 | ab=00 | none | mux_in[0]=1
/// c=1,d=1 | ab=00 | none | mux_in[0]=1
/// c=1,d=0 | ab=00 | none | mux_in[0]=1
/// any c,d | ab=01 | none | mux_in[1]=0
/// c=0,d=0 | ab=10 | none | mux_in[2]=1
/// c=0,d=1 | ab=10 | none | mux_in[2]=0
/// c=1,d=1 | ab=10 | none | mux_in[2]=0
/// c=1,d=0 | ab=10 | none | mux_in[2]=1
/// c=0,d=0 | ab=11 | none | mux_in[3]=0
/// c=0,d=1 | ab=11 | none | mux_in[3]=0
/// c=1,d=1 | ab=11 | none | mux_in[3]=1
/// c=1,d=0 | ab=11 | none | mux_in[3]=0
/// Port timing/type: c and d are combinational inputs; mux_in is a same-cycle
/// combinational output vector with no registered latency.
module TopModule (
  input logic c,
  input logic d,
  output logic [3:0] mux_in
);

  logic mux0;
  logic mux1;
  logic mux2;
  logic mux3;
  assign mux0 = d ? 1'b1 : c;
  assign mux1 = 1'b0;
  assign mux2 = d ? 1'b0 : 1'b1;
  assign mux3 = d ? c : 1'b0;
  assign mux_in = {mux3, mux2, mux1, mux0};

endmodule

