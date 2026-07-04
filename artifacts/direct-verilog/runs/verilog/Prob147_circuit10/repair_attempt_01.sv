
module TopModule (
    input  logic clk,
    input  logic a,
    input  logic b,
    output logic q,
    output logic state
);

    always @(posedge clk) begin
        state <= state ? (a | b) : (a & b);
    end

    assign q = a ^ b ^ state;

endmodule
