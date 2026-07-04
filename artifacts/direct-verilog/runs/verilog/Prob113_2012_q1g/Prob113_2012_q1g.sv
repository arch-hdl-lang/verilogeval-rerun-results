
module TopModule (
    input  logic [3:0] x,
    output logic       f
);

    assign f = (x == 4'd0) || (x == 4'd1) || (x == 4'd4) || (x == 4'd5) ||
               (x == 4'd6) || (x == 4'd12) || (x == 4'd14) || (x == 4'd15);

endmodule

