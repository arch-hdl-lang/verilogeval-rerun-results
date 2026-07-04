//! ---
//! spec_md: dataset_spec-to-rtl/Prob145_circuit8_prompt.txt
//! tags: [sequential, latch, waveform]
//! refs: []
//! ---
//!
//! Implements the waveform-derived sequential circuit for Prob145_circuit8.
//! The observed behavior is a high-transparent latch for p followed by an
//! equivalent falling-edge sample for q, since p is stable while clock is low.
/// One-bit latch storage using the ARCH latch regfile primitive.
///
/// Row zero is used as the stored latch bit; the second row only keeps the
/// address width nonzero for portable generated SystemVerilog.
module BitLatchStore #(
  parameter int NREGS = 2,
  parameter int T = 1
) (
  input logic clk,
  input logic [0:0] read_addr,
  output logic [T-1:0] read_data,
  input logic write_en,
  input logic [0:0] write_addr,
  input logic [T-1:0] write_data
);

  logic [T-1:0] rf_data [0:NREGS-1];
  
  always_latch begin
    if (write_en && write_addr == 1'd0)
      rf_data[0] = write_data;
  end
  always_latch begin
    if (write_en && write_addr == 1'd1)
      rf_data[1] = write_data;
  end
  
  always_comb begin
    if (write_en && write_addr == read_addr)
      read_data = write_data;
    else
      read_data = rf_data[read_addr];
  end

endmodule

/// Top-level waveform-derived sequential circuit.
///
/// p is transparent while clock is high and otherwise holds. q captures that
/// held p value on each falling clock edge.
module TopModule (
  input logic clock,
  input logic a,
  output logic p,
  output logic q
);

  logic [0:0] zero_addr = 0;
  BitLatchStore p_store (
    .clk(clock),
    .read_addr(zero_addr),
    .read_data(p),
    .write_en(clock),
    .write_addr(zero_addr),
    .write_data(a)
  );
  always_ff @(negedge clock) begin
    q <= p;
  end

endmodule

