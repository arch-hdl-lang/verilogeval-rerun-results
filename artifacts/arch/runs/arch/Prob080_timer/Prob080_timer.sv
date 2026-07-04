//! ---
//! spec_md: dataset_spec-to-rtl/Prob080_timer_prompt.txt
//! tags: [timer, counter, terminal_count]
//! refs: []
//! ---
//!
//! Implements a positive-edge-triggered countdown timer with a loadable
//! 10-bit counter and a combinational terminal-count output.
/// Top-level timer for Prob080_timer.
///
/// Port timing/type:
/// - `clk`: positive-edge clock input.
/// - `load`: one-bit input sampled on the positive edge of `clk`.
/// - `data`: 10-bit input sampled on the positive edge when `load` is high.
/// - `tc`: combinational output, high when the current counter value is zero.
///
/// Transition table:
/// | Input condition | Current counter | Next counter | Output `tc` |
/// | --- | --- | --- | --- |
/// | `load == 1` | any value | `data` | current `counter == 0` before the edge; after the edge reflects `data == 0` |
/// | `load == 0 && counter != 0` | nonzero | `counter - 1` | `0` before the edge; after the edge reflects whether decremented value is zero |
/// | `load == 0 && counter == 0` | zero | zero | `1` |
module TopModule (
  input logic clk,
  input logic load,
  input logic [9:0] data,
  output logic tc
);

  logic [9:0] remaining = 0;
  assign tc = remaining == 0;
  always_ff @(posedge clk) begin
    if (load) begin
      remaining <= data;
    end else if (remaining != 0) begin
      remaining <= (10 > 1 ? 10 : 1)'(remaining - 1);
    end else begin
      remaining <= remaining;
    end
  end

endmodule

