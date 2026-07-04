module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    localparam logic [3:0] S0     = 4'd0;
    localparam logic [3:0] S1     = 4'd1;
    localparam logic [3:0] S2     = 4'd2;
    localparam logic [3:0] S3     = 4'd3;
    localparam logic [3:0] S4     = 4'd4;
    localparam logic [3:0] S5     = 4'd5;
    localparam logic [3:0] S6     = 4'd6;
    localparam logic [3:0] SDISC  = 4'd7;
    localparam logic [3:0] SFLAG  = 4'd8;
    localparam logic [3:0] SERR   = 4'd9;

    logic [3:0] state;
    logic [3:0] next_state;

    always @(*) begin
        next_state = state;
        case (state)
            S0:    next_state = in ? S1 : S0;
            S1:    next_state = in ? S2 : S0;
            S2:    next_state = in ? S3 : S0;
            S3:    next_state = in ? S4 : S0;
            S4:    next_state = in ? S5 : S0;
            S5:    next_state = in ? S6 : SDISC;
            S6:    next_state = in ? SERR : SFLAG;
            SDISC: next_state = in ? S1 : S0;
            SFLAG: next_state = in ? S1 : S0;
            SERR:  next_state = in ? SERR : S0;
            default: next_state = S0;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    assign disc = (state == SDISC);
    assign flag = (state == SFLAG);
    assign err  = (state == SERR);

endmodule
