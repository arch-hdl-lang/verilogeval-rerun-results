//! ---
//! spec_md: dataset_spec-to-rtl/Prob153_gshare_prompt.txt
//! tags: [branch-prediction, gshare, saturating-counter, history]
//! ---
//!
//! Implements a 7-bit gshare branch predictor with a 128-entry table of
//! two-bit saturating counters and a recoverable global history register.
/// Top-level gshare branch predictor.
///
/// Prediction outputs are combinational from the current PHT and global
/// history. The global history and PHT update on the positive clock edge,
/// with asynchronous active-high reset and misprediction recovery taking
/// precedence over speculative prediction history updates.
module TopModule (
  input logic clk,
  input logic areset,
  input logic predict_valid,
  input logic [6:0] predict_pc,
  output logic predict_taken,
  output logic [6:0] predict_history,
  input logic train_valid,
  input logic train_taken,
  input logic train_mispredicted,
  input logic [6:0] train_history,
  input logic [6:0] train_pc
);

  logic [6:0] predict_idx;
  logic [6:0] train_idx;
  logic [127:0] predict_hi_shifted;
  logic [127:0] predict_lo_shifted;
  logic [127:0] train_hi_shifted;
  logic [127:0] train_lo_shifted;
  logic [1:0] predict_ctr;
  logic [1:0] train_ctr;
  logic predicted_dir;
  logic [6:0] train_next_history;
  logic [6:0] predict_next_history;
  logic [1:0] train_inc_ctr;
  logic [1:0] train_dec_ctr;
  logic [1:0] train_updated_ctr;
  logic [127:0] train_onehot;
  logic [127:0] pht_clear_mask;
  logic [127:0] pht_updated_hi;
  logic [127:0] pht_updated_lo;
  logic [6:0] history_reg;
  assign predict_idx = predict_pc ^ history_reg;
  assign train_idx = train_pc ^ train_history;
  assign predict_hi_shifted = pht_hi >> predict_idx;
  assign predict_lo_shifted = pht_lo >> predict_idx;
  assign train_hi_shifted = pht_hi >> train_idx;
  assign train_lo_shifted = pht_lo >> train_idx;
  assign predict_ctr = {predict_hi_shifted[0], predict_lo_shifted[0]};
  assign train_ctr = {train_hi_shifted[0], train_lo_shifted[0]};
  assign predicted_dir = predict_ctr[1];
  assign train_next_history = {train_history[5:0], train_taken};
  assign predict_next_history = {history_reg[5:0], predicted_dir};
  assign train_inc_ctr = (2 > 1 ? 2 : 1)'(train_ctr + 1);
  assign train_dec_ctr = (2 > 1 ? 2 : 1)'(train_ctr - 1);
  assign train_updated_ctr = train_taken ? train_inc_ctr : train_dec_ctr;
  assign train_onehot = 128'd1 << train_idx;
  assign pht_clear_mask = ~train_onehot;
  assign pht_updated_hi = (pht_hi & pht_clear_mask) | 128'($unsigned(train_updated_ctr[1])) << train_idx;
  assign pht_updated_lo = (pht_lo & pht_clear_mask) | 128'($unsigned(train_updated_ctr[0])) << train_idx;
  assign predict_taken = predicted_dir;
  assign predict_history = history_reg;
  logic [127:0] pht_hi;
  logic [127:0] pht_lo;
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      history_reg <= 0;
      pht_hi <= 0;
      pht_lo <= ~0;
    end else begin
      if (train_valid) begin
        if (train_taken) begin
          if (train_ctr != 3) begin
            pht_hi <= pht_updated_hi;
            pht_lo <= pht_updated_lo;
          end
        end else if (train_ctr != 0) begin
          pht_hi <= pht_updated_hi;
          pht_lo <= pht_updated_lo;
        end
      end
      if (train_valid && train_mispredicted) begin
        history_reg <= train_next_history;
      end else if (predict_valid) begin
        history_reg <= predict_next_history;
      end
    end
  end

endmodule

