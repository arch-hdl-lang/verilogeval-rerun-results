
module TopModule (
    input  logic clock,
    input  logic a,
    output logic p,
    output logic q
);

    always @(*) begin
        if (clock) begin
            p = a;
        end
    end

    always @(*) begin
        if (!clock) begin
            q = p;
        end
    end

endmodule

