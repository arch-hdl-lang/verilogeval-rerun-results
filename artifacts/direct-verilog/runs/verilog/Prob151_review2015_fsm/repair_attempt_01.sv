module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic data,
    input  logic done_counting,
    input  logic ack,
    output logic shift_ena,
    output logic counting,
    output logic done
);

    localparam logic [3:0] S_IDLE   = 4'd0;
    localparam logic [3:0] S_1      = 4'd1;
    localparam logic [3:0] S_11     = 4'd2;
    localparam logic [3:0] S_110    = 4'd3;
    localparam logic [3:0] S_SHIFT0 = 4'd4;
    localparam logic [3:0] S_SHIFT1 = 4'd5;
    localparam logic [3:0] S_SHIFT2 = 4'd6;
    localparam logic [3:0] S_SHIFT3 = 4'd7;
    localparam logic [3:0] S_COUNT  = 4'd8;
    localparam logic [3:0] S_DONE   = 4'd9;

    logic [3:0] state, next_state;

    always_comb begin
        next_state = state;

        case (state)
            S_IDLE:   next_state = data ? S_1 : S_IDLE;
            S_1:      next_state = data ? S_11 : S_IDLE;
            S_11:     next_state = data ? S_11 : S_110;
            S_110:    next_state = data ? S_SHIFT0 : S_IDLE;
            S_SHIFT0: next_state = S_SHIFT1;
            S_SHIFT1: next_state = S_SHIFT2;
            S_SHIFT2: next_state = S_SHIFT3;
            S_SHIFT3: next_state = S_COUNT;
            S_COUNT:  next_state = done_counting ? S_DONE : S_COUNT;
            S_DONE:   next_state = ack ? S_IDLE : S_DONE;
            default:  next_state = S_IDLE;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    assign shift_ena = (state == S_SHIFT0) || (state == S_SHIFT1) ||
                       (state == S_SHIFT2) || (state == S_SHIFT3);
    assign counting  = (state == S_COUNT);
    assign done      = (state == S_DONE);

endmodule
