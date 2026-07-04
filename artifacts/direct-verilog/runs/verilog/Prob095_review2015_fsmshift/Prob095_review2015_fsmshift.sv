
module TopModule (
    input  logic clk,
    input  logic reset,
    output logic shift_ena
);

    logic [1:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 2'd0;
            shift_ena <= 1'b1;
        end else if (shift_ena) begin
            if (count == 2'd3) begin
                shift_ena <= 1'b0;
            end else begin
                count <= count + 2'd1;
            end
        end
    end

endmodule

