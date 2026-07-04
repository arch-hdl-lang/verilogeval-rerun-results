module TopModule (
    input  logic clk,
    input  logic in,
    output logic out
);

    initial begin
        out = 1'b0;
    end

    always @(posedge clk) begin
        out <= in ^ out;
    end

endmodule
