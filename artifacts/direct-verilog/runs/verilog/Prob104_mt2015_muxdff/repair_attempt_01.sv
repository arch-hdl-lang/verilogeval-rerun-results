module TopModule (
    input  logic clk,
    input  logic L,
    input  logic q_in,
    input  logic r_in,
    output logic Q
);

    initial begin
        Q = 1'b0;
    end

    always_ff @(posedge clk) begin
        Q <= L ? r_in : q_in;
    end

endmodule
