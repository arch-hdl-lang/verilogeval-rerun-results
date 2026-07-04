module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic s,
    input  logic w,
    output logic z
);

    logic active;
    logic [1:0] sample_idx;
    logic [1:0] ones_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            active     <= 1'b0;
            sample_idx <= 2'd0;
            ones_count <= 2'd0;
            z          <= 1'b0;
        end else begin
            z <= 1'b0;

            if (!active) begin
                if (s) begin
                    active     <= 1'b1;
                    sample_idx <= 2'd0;
                    ones_count <= 2'd0;
                end
            end else if (sample_idx == 2'd2) begin
                z          <= (ones_count + {1'b0, w}) == 2'd2;
                sample_idx <= 2'd0;
                ones_count <= 2'd0;
            end else begin
                sample_idx <= sample_idx + 2'd1;
                ones_count <= ones_count + {1'b0, w};
            end
        end
    end

endmodule
