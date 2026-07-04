
module TopModule (
    input  logic       clk,
    input  logic       reset,
    input  logic       data,
    output logic [3:0] count,
    output logic       counting,
    output logic       done,
    input  logic       ack
);

    typedef enum logic [1:0] {
        S_SEARCH,
        S_SHIFT,
        S_COUNT,
        S_DONE
    } state_t;

    state_t state;
    logic [3:0] pattern_shift;
    logic [3:0] delay_value;
    logic [1:0] shift_count;
    logic [9:0] cycle_count;

    assign counting = (state == S_COUNT);
    assign done = (state == S_DONE);
    assign count = delay_value;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S_SEARCH;
            pattern_shift <= 4'b0000;
            delay_value <= 4'b0000;
            shift_count <= 2'b00;
            cycle_count <= 10'd0;
        end else begin
            case (state)
                S_SEARCH: begin
                    pattern_shift <= {pattern_shift[2:0], data};
                    if ({pattern_shift[2:0], data} == 4'b1101) begin
                        state <= S_SHIFT;
                        delay_value <= 4'b0000;
                        shift_count <= 2'b00;
                    end
                end

                S_SHIFT: begin
                    delay_value <= {delay_value[2:0], data};
                    if (shift_count == 2'd3) begin
                        state <= S_COUNT;
                        cycle_count <= 10'd0;
                    end else begin
                        shift_count <= shift_count + 2'd1;
                    end
                end

                S_COUNT: begin
                    if (cycle_count == 10'd999) begin
                        cycle_count <= 10'd0;
                        if (delay_value == 4'd0) begin
                            state <= S_DONE;
                        end else begin
                            delay_value <= delay_value - 4'd1;
                        end
                    end else begin
                        cycle_count <= cycle_count + 10'd1;
                    end
                end

                S_DONE: begin
                    if (ack) begin
                        state <= S_SEARCH;
                        pattern_shift <= 4'b0000;
                    end
                end

                default: begin
                    state <= S_SEARCH;
                    pattern_shift <= 4'b0000;
                    delay_value <= 4'b0000;
                    shift_count <= 2'b00;
                    cycle_count <= 10'd0;
                end
            endcase
        end
    end

endmodule

