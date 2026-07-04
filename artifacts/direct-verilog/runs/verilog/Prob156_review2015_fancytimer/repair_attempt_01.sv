module TopModule (
    input  logic       clk,
    input  logic       reset,
    input  logic       data,
    output logic [3:0] count,
    output logic       counting,
    output logic       done,
    input  logic       ack
);

    localparam logic [1:0] SEARCH = 2'd0;
    localparam logic [1:0] LOAD   = 2'd1;
    localparam logic [1:0] RUN    = 2'd2;
    localparam logic [1:0] WAIT   = 2'd3;

    logic [1:0] state;
    logic [3:0] seq;
    logic [3:0] remaining;
    logic [1:0] bit_count;
    logic [9:0] tick;

    assign count = remaining;
    assign counting = (state == RUN);
    assign done = (state == WAIT);

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= SEARCH;
            seq <= 4'd0;
            remaining <= 4'd0;
            bit_count <= 2'd0;
            tick <= 10'd0;
        end else begin
            case (state)
                SEARCH: begin
                    seq <= {seq[2:0], data};
                    if ({seq[2:0], data} == 4'b1101) begin
                        state <= LOAD;
                        remaining <= 4'd0;
                        bit_count <= 2'd0;
                    end
                end

                LOAD: begin
                    remaining <= {remaining[2:0], data};
                    if (bit_count == 2'd3) begin
                        state <= RUN;
                        tick <= 10'd0;
                    end else begin
                        bit_count <= bit_count + 2'd1;
                    end
                end

                RUN: begin
                    if (tick == 10'd999) begin
                        tick <= 10'd0;
                        if (remaining == 4'd0) begin
                            state <= WAIT;
                        end else begin
                            remaining <= remaining - 4'd1;
                        end
                    end else begin
                        tick <= tick + 10'd1;
                    end
                end

                WAIT: begin
                    if (ack) begin
                        state <= SEARCH;
                        seq <= 4'd0;
                    end
                end
            endcase
        end
    end

endmodule
