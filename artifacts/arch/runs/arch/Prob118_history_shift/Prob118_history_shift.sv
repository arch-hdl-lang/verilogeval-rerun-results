//! ---
//! spec_md: dataset_spec-to-rtl/Prob118_history_shift_prompt.txt
//! tags: [branch-history, shift-register, rollback, async-reset]
//! refs: []
//! ---
//!
//! Implements a 32-bit global branch history register. Predictions shift the
//! predicted direction into the youngest bit, while misprediction recovery
//! restores the supplied pre-branch history plus the resolved branch result.
/// Top-level 32-bit global branch history register.
///
/// `predict_history` is the current register value. Sequential updates occur
/// on the rising edge of `clk`; active-high asynchronous reset clears history,
/// and misprediction recovery has priority over prediction updates.
module TopModule (
  input logic clk,
  input logic areset,
  input logic predict_valid,
  input logic predict_taken,
  input logic train_mispredicted,
  input logic train_taken,
  input logic [31:0] train_history,
  output logic [31:0] predict_history
);

  logic [31:0] history;
  assign predict_history = history;
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      history <= 0;
    end else begin
      if (train_mispredicted) begin
        history <= {train_history[30:0], train_taken};
      end else if (predict_valid) begin
        history <= {history[30:0], predict_taken};
      end
    end
  end

endmodule

