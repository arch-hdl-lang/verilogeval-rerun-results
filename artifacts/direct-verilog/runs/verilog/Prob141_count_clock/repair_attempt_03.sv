module TopModule (
    input  logic       clk,
    input  logic       reset,
    input  logic       ena,
    output logic       pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    logic [3:0] hour;
    logic [5:0] minute;
    logic [5:0] second;
    logic [3:0] minute_tens, minute_ones;
    logic [3:0] second_tens, second_ones;

    initial begin
        #1000000 $finish;
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            pm <= 1'b0;
            hour <= 4'd12;
            minute <= 6'd0;
            second <= 6'd0;
        end else if (ena) begin
            if (second == 6'd59) begin
                second <= 6'd0;
                if (minute == 6'd59) begin
                    minute <= 6'd0;
                    if (hour == 4'd11) begin
                        hour <= 4'd12;
                        pm <= ~pm;
                    end else if (hour == 4'd12) begin
                        hour <= 4'd1;
                    end else begin
                        hour <= hour + 4'd1;
                    end
                end else begin
                    minute <= minute + 6'd1;
                end
            end else begin
                second <= second + 6'd1;
            end
        end
    end

    always_comb begin
        case (hour)
            4'd1:  hh = 8'h01;
            4'd2:  hh = 8'h02;
            4'd3:  hh = 8'h03;
            4'd4:  hh = 8'h04;
            4'd5:  hh = 8'h05;
            4'd6:  hh = 8'h06;
            4'd7:  hh = 8'h07;
            4'd8:  hh = 8'h08;
            4'd9:  hh = 8'h09;
            4'd10: hh = 8'h10;
            4'd11: hh = 8'h11;
            default: hh = 8'h12;
        endcase

        minute_tens = minute / 6'd10;
        minute_ones = minute - (minute_tens * 4'd10);
        second_tens = second / 6'd10;
        second_ones = second - (second_tens * 4'd10);
        mm = {minute_tens, minute_ones};
        ss = {second_tens, second_ones};
    end

endmodule
