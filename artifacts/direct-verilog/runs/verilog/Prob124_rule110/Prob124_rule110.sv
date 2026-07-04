
module TopModule (
    input  logic         clk,
    input  logic         load,
    input  logic [511:0] data,
    output logic [511:0] q
);

    logic [511:0] left;
    logic [511:0] right;
    logic [511:0] next_q;

    assign left   = {1'b0, q[511:1]};
    assign right  = {q[510:0], 1'b0};
    assign next_q = (q & ~left) | (q ^ right);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

endmodule

