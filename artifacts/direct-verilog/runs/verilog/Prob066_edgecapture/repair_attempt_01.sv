module TopModule (
    input  logic        clk,
    input  logic        reset,
    input  logic [31:0] in,
    output logic [31:0] out
);

    logic [31:0] prev_in;

    always @(posedge clk) begin
        prev_in <= in;

        if (reset) begin
            out <= 32'b0;
        end else begin
            out <= out | (prev_in & ~in);
        end
    end

endmodule
