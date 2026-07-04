//! ---
//! spec_md: dataset_spec-to-rtl/Prob141_count_clock_prompt.txt
//! tags: [clock, bcd, counter]
//! ---
//!
//! Implements a synchronous 12-hour BCD clock with AM/PM indication. The
//! clock advances by one second on each enabled cycle and resets to 12:00:00 AM.
/// Top-level 12-hour BCD clock.
///
/// Maintains seconds, minutes, hours, and AM/PM state with synchronous
/// active-high reset and enable-gated one-second increments.
module TopModule (
  input logic clk,
  input logic reset,
  input logic ena,
  output logic pm,
  output logic [7:0] hh,
  output logic [7:0] mm,
  output logic [7:0] ss
);

  logic pm_r;
  logic [7:0] hh_r;
  logic [7:0] mm_r;
  logic [7:0] ss_r;
  assign pm = pm_r;
  assign hh = hh_r;
  assign mm = mm_r;
  assign ss = ss_r;
  always_ff @(posedge clk) begin
    if (reset) begin
      hh_r <= 8'd18;
      mm_r <= 8'd0;
      pm_r <= 1'b0;
      ss_r <= 8'd0;
    end else begin
      if (ena) begin
        if (ss_r == 8'd89) begin
          ss_r <= 8'd0;
          if (mm_r == 8'd89) begin
            mm_r <= 8'd0;
            if (hh_r == 8'd17) begin
              hh_r <= 8'd18;
              pm_r <= !pm_r;
            end else if (hh_r == 8'd18) begin
              hh_r <= 8'd1;
            end else if (hh_r[3:0] == 4'd9) begin
              hh_r <= {($bits(hh_r[7:4]) > 4 ? $bits(hh_r[7:4]) : 4)'(hh_r[7:4] + 4'd1), 4'd0};
            end else begin
              hh_r <= 8'(hh_r + 8'd1);
            end
          end else if (mm_r[3:0] == 4'd9) begin
            mm_r <= {($bits(mm_r[7:4]) > 4 ? $bits(mm_r[7:4]) : 4)'(mm_r[7:4] + 4'd1), 4'd0};
          end else begin
            mm_r <= 8'(mm_r + 8'd1);
          end
        end else if (ss_r[3:0] == 4'd9) begin
          ss_r <= {($bits(ss_r[7:4]) > 4 ? $bits(ss_r[7:4]) : 4)'(ss_r[7:4] + 4'd1), 4'd0};
        end else begin
          ss_r <= 8'(ss_r + 8'd1);
        end
      end
    end
  end

endmodule

