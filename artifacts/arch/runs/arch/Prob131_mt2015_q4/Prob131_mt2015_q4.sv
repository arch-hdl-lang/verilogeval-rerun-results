//! ---
//! spec_md: dataset_spec-to-rtl/Prob131_mt2015_q4_prompt.txt
//! tags: [combinational, boolean, structural]
//! refs: []
//! ---
//!
//! Structural combinational implementation of the requested TopModule. The A submodule computes
//! `(x ^ y) & x`, the B submodule waveform is equivalent to equality/XNOR, and TopModule combines
//! two copies of each through OR, AND, and XOR as specified.
/// Boolean submodule A from the prompt.
///
/// Computes z = (x ^ y) & x for one-bit inputs.
module ModuleA (
  input logic x,
  input logic y,
  output logic z
);

  assign z = (x ^ y) & x;

endmodule

/// Boolean submodule B inferred from the prompt waveform.
///
/// The waveform maps 00 and 11 to 1, and 01 and 10 to 0, so this is XNOR/equality.
module ModuleB (
  input logic x,
  input logic y,
  output logic z
);

  assign z = x == y;

endmodule

/// Top-level structural composition requested by the problem.
///
/// All four submodules receive x and y. The first A/B pair feeds an OR, the second pair feeds an
/// AND, and those two gate outputs feed the final XOR output z.
module TopModule (
  input logic x,
  input logic y,
  output logic z
);

  logic a_or_in;
  logic b_or_in;
  logic a_and_in;
  logic b_and_in;
  assign z = (a_or_in | b_or_in) ^ (a_and_in & b_and_in);
  ModuleA a0 (
    .x(x),
    .y(y),
    .z(a_or_in)
  );
  ModuleB b0 (
    .x(x),
    .y(y),
    .z(b_or_in)
  );
  ModuleA a1 (
    .x(x),
    .y(y),
    .z(a_and_in)
  );
  ModuleB b1 (
    .x(x),
    .y(y),
    .z(b_and_in)
  );

endmodule

