
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        DATA,
        STOP,
        DONE,
        WAIT_STOP
    } state_t;

    state_t state, next_state;
    logic [2:0] bit_count;

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (!in)
                    next_state = DATA;
            end
            DATA: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
            end
            STOP: begin
                if (in)
                    next_state = DONE;
                else
                    next_state = WAIT_STOP;
            end
            DONE: begin
                if (!in)
                    next_state = DATA;
                else
                    next_state = IDLE;
            end
            WAIT_STOP: begin
                if (in)
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
        end else begin
            state <= next_state;
            if (state == IDLE && !in)
                bit_count <= 3'd0;
            else if (state == DONE && !in)
                bit_count <= 3'd0;
            else if (state == DATA)
                bit_count <= bit_count + 3'd1;
            else
                bit_count <= 3'd0;
        end
    end

    assign done = (state == DONE);

endmodule

