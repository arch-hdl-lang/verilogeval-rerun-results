
module TopModule (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [7:0] c,
    input  logic [7:0] d,
    output logic [7:0] min
);

    always @(*) begin
        min = a;
        if (b < min) begin
            min = b;
        end
        if (c < min) begin
            min = c;
        end
        if (d < min) begin
            min = d;
        end
    end

endmodule

