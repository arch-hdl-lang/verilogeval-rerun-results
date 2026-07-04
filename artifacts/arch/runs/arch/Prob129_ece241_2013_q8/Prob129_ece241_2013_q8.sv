//! ---
//! spec_md: dataset_spec-to-rtl/Prob129_ece241_2013_q8_prompt.txt
//! tags: [fsm, mealy, sequence_detector, overlapping, async_reset]
//! refs: []
//! ---
//!
//! Three-state Mealy sequence detector for overlapping occurrences of the input pattern 101.
//! State updates occur on the positive edge of clk, and aresetn is an active-low asynchronous reset.
/// Top-level three-state Mealy sequence detector for overlapping 101 sequences.
///
/// Port timing/type notes: clk is the positive-edge sampling clock; aresetn is a negative-edge active-low asynchronous reset; x is sampled by the state transition logic on clk rising and also drives the same-cycle Mealy output; z is a combinational output.
/// Transition table:
/// input condition | current state | next state | output z
/// x == 0 | S0 | S0 | 0
/// x == 1 | S0 | S1 | 0
/// x == 0 | S1 | S10 | 0
/// x == 1 | S1 | S1 | 0
/// x == 0 | S10 | S0 | 0
/// x == 1 | S10 | S1 | 1
module TopModule (
  input logic clk,
  input logic aresetn,
  input logic x,
  output logic z
);

  logic [1:0] prefix;
  assign z = prefix == 2'd2 && x;
  always_ff @(posedge clk or negedge aresetn) begin
    if ((!aresetn)) begin
      prefix <= 0;
    end else begin
      if (prefix == 2'd0) begin
        if (x) begin
          prefix <= 2'd1;
        end else begin
          prefix <= 2'd0;
        end
      end else if (prefix == 2'd1) begin
        if (x) begin
          prefix <= 2'd1;
        end else begin
          prefix <= 2'd2;
        end
      end else if (x) begin
        prefix <= 2'd1;
      end else begin
        prefix <= 2'd0;
      end
    end
  end

endmodule

