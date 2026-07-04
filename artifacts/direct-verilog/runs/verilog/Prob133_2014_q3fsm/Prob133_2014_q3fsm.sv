
```verilog
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic s,
    input  logic w,
    output logic z
);

    logic [1:0] state;
    logic [1:0] count;
    logic       active;

    always @(posedge clk) begin
        if (reset) begin
            active <= 1'b0;
            state  <= 2'd0;
            count  <= 2'd0;
            z      <= 1'b0;
        end else begin
            z <= 1'b0;

            if (!active) begin
                if (s) begin
                    active <= 1'b1;
                    state  <= 2'd0;
                    count  <= 2'd0;
                end
            end else begin
                if (state == 2'd2) begin
                    z     <= ((count + {1'b0, w}) == 2'd2);
                    state <= 2'd0;
                    count <= 2'd0;
                end else begin
                    state <= state + 2'd1;
                    count <= count + {1'b0, w};
                end
            end
        end
    end

endmodule
```

