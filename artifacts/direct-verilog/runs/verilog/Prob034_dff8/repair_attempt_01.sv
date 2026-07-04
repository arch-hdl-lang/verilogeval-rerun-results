module TopModule (
    input  logic       clk,
    input  logic [7:0] d,
    output logic [7:0] q
);

    initial begin
        q = 8'b00000000;
    end

    always @(posedge clk) begin
        q <= d;
    end

endmodule
