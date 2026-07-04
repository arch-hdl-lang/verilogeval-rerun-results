//! ---
//! spec_md: dataset_spec-to-rtl/Prob075_counter_2bc_prompt.txt
//! tags: [counter, saturating-counter, async-reset, branch-predictor]
//! refs: []
//! ---
//!
//! Implements the requested two-bit saturating counter for branch training.
//! The asynchronous active-high reset initializes the counter to weakly
//! not-taken, and the state output continuously reflects the stored count.
/// Top-level two-bit saturating counter with the exact requested interface.
///
/// `state` is a combinational view of the internal counter. Sequential updates
/// occur on the positive clock edge, with active-high asynchronous reset to
/// `2'b01`.
module TopModule (
  input logic clk,
  input logic areset,
  input logic train_valid,
  input logic train_taken,
  output logic [1:0] state
);

  logic [1:0] count_r;
  assign state = count_r;
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      count_r <= 2'd1;
    end else begin
      if (train_valid) begin
        if (train_taken) begin
          if (count_r != 2'd3) begin
            count_r <= 2'(count_r + 2'd1);
          end
        end else if (count_r != 2'd0) begin
          count_r <= 2'(count_r - 2'd1);
        end
      end
    end
  end

endmodule

