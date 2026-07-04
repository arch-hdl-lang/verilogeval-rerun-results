//! ---
//! spec_md: dataset_spec-to-rtl/Prob052_gates100_prompt.txt
//! tags: [combinational, gates, reduction]
//! ---
//!
//! Implements the VerilogEval Prob052_gates100 combinational gate reductions.
/// Top-level combinational reduction module for 100 one-bit inputs.
///
/// Produces the 100-input AND, OR, and XOR of in[99:0].
module TopModule (
  input logic [99:0] in,
  output logic out_and,
  output logic out_or,
  output logic out_xor
);

  logic and_0_24;
  logic and_25_49;
  logic and_50_74;
  logic and_75_99;
  logic or_0_24;
  logic or_25_49;
  logic or_50_74;
  logic or_75_99;
  logic xor_0_24;
  logic xor_25_49;
  logic xor_50_74;
  logic xor_75_99;
  assign and_0_24 = in[0] & in[1] & in[2] & in[3] & in[4] & in[5] & in[6] & in[7] & in[8] & in[9] & in[10] & in[11] & in[12] & in[13] & in[14] & in[15] & in[16] & in[17] & in[18] & in[19] & in[20] & in[21] & in[22] & in[23] & in[24];
  assign and_25_49 = in[25] & in[26] & in[27] & in[28] & in[29] & in[30] & in[31] & in[32] & in[33] & in[34] & in[35] & in[36] & in[37] & in[38] & in[39] & in[40] & in[41] & in[42] & in[43] & in[44] & in[45] & in[46] & in[47] & in[48] & in[49];
  assign and_50_74 = in[50] & in[51] & in[52] & in[53] & in[54] & in[55] & in[56] & in[57] & in[58] & in[59] & in[60] & in[61] & in[62] & in[63] & in[64] & in[65] & in[66] & in[67] & in[68] & in[69] & in[70] & in[71] & in[72] & in[73] & in[74];
  assign and_75_99 = in[75] & in[76] & in[77] & in[78] & in[79] & in[80] & in[81] & in[82] & in[83] & in[84] & in[85] & in[86] & in[87] & in[88] & in[89] & in[90] & in[91] & in[92] & in[93] & in[94] & in[95] & in[96] & in[97] & in[98] & in[99];
  assign out_and = and_0_24 & and_25_49 & and_50_74 & and_75_99;
  assign or_0_24 = in[0] | in[1] | in[2] | in[3] | in[4] | in[5] | in[6] | in[7] | in[8] | in[9] | in[10] | in[11] | in[12] | in[13] | in[14] | in[15] | in[16] | in[17] | in[18] | in[19] | in[20] | in[21] | in[22] | in[23] | in[24];
  assign or_25_49 = in[25] | in[26] | in[27] | in[28] | in[29] | in[30] | in[31] | in[32] | in[33] | in[34] | in[35] | in[36] | in[37] | in[38] | in[39] | in[40] | in[41] | in[42] | in[43] | in[44] | in[45] | in[46] | in[47] | in[48] | in[49];
  assign or_50_74 = in[50] | in[51] | in[52] | in[53] | in[54] | in[55] | in[56] | in[57] | in[58] | in[59] | in[60] | in[61] | in[62] | in[63] | in[64] | in[65] | in[66] | in[67] | in[68] | in[69] | in[70] | in[71] | in[72] | in[73] | in[74];
  assign or_75_99 = in[75] | in[76] | in[77] | in[78] | in[79] | in[80] | in[81] | in[82] | in[83] | in[84] | in[85] | in[86] | in[87] | in[88] | in[89] | in[90] | in[91] | in[92] | in[93] | in[94] | in[95] | in[96] | in[97] | in[98] | in[99];
  assign out_or = or_0_24 | or_25_49 | or_50_74 | or_75_99;
  assign xor_0_24 = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7] ^ in[8] ^ in[9] ^ in[10] ^ in[11] ^ in[12] ^ in[13] ^ in[14] ^ in[15] ^ in[16] ^ in[17] ^ in[18] ^ in[19] ^ in[20] ^ in[21] ^ in[22] ^ in[23] ^ in[24];
  assign xor_25_49 = in[25] ^ in[26] ^ in[27] ^ in[28] ^ in[29] ^ in[30] ^ in[31] ^ in[32] ^ in[33] ^ in[34] ^ in[35] ^ in[36] ^ in[37] ^ in[38] ^ in[39] ^ in[40] ^ in[41] ^ in[42] ^ in[43] ^ in[44] ^ in[45] ^ in[46] ^ in[47] ^ in[48] ^ in[49];
  assign xor_50_74 = in[50] ^ in[51] ^ in[52] ^ in[53] ^ in[54] ^ in[55] ^ in[56] ^ in[57] ^ in[58] ^ in[59] ^ in[60] ^ in[61] ^ in[62] ^ in[63] ^ in[64] ^ in[65] ^ in[66] ^ in[67] ^ in[68] ^ in[69] ^ in[70] ^ in[71] ^ in[72] ^ in[73] ^ in[74];
  assign xor_75_99 = in[75] ^ in[76] ^ in[77] ^ in[78] ^ in[79] ^ in[80] ^ in[81] ^ in[82] ^ in[83] ^ in[84] ^ in[85] ^ in[86] ^ in[87] ^ in[88] ^ in[89] ^ in[90] ^ in[91] ^ in[92] ^ in[93] ^ in[94] ^ in[95] ^ in[96] ^ in[97] ^ in[98] ^ in[99];
  assign out_xor = xor_0_24 ^ xor_25_49 ^ xor_50_74 ^ xor_75_99;

endmodule

