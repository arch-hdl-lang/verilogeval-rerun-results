
module TopModule (
    input  logic       clk,
    input  logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] in_prev;

    always @(posedge clk) begin
        in_prev <= in;
        pedge <= ~in_prev & in;
    end

endmodule

