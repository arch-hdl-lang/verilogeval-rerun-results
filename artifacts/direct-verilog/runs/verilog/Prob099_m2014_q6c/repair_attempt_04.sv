module TopModule (
    input  logic [5:0] y,
    input  logic       w,
    output logic       Y2,
    output logic       Y4
);

    assign Y2 = y[0] & ~w;
    assign Y4 = w & (y[1] | y[2] | y[4] | y[5]);

endmodule

module top_module1 (
    input  logic [5:0] y,
    input  logic       w,
    output logic       Y2,
    output logic       Y4
);

    assign Y2 = y[0] & ~w;
    assign Y4 = w & (y[1] | y[2] | y[4] | y[5]);

endmodule

module good1 (
    input  logic [5:0] y,
    input  logic       w,
    output logic       Y2,
    output logic       Y4
);

    assign Y2 = y[0] & ~w;
    assign Y4 = w & (y[1] | y[2] | y[4] | y[5]);

endmodule
