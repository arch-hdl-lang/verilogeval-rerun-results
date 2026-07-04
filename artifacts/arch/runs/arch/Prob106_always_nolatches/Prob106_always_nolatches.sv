//! ---
//! spec_md: dataset_spec-to-rtl/Prob106_always_nolatches_prompt.txt
//! tags: [keyboard, scancode, decoder]
//! ---
//!
//! Combinational PS/2 arrow-key decoder. The 16-bit scancode input is compared
//! against the four extended arrow-key make codes and drives one one-bit output
//! per recognized direction.
/// Top-level combinational decoder for PS/2 arrow-key scancodes.
module TopModule (
  input logic [15:0] scancode,
  output logic left,
  output logic down,
  output logic right,
  output logic up
);

  assign left = scancode == 16'd57451;
  assign down = scancode == 16'd57458;
  assign right = scancode == 16'd57460;
  assign up = scancode == 16'd57461;

endmodule

