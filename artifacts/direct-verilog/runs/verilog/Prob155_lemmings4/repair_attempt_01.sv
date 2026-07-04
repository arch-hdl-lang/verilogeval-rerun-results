
module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic bump_left,
    input  logic bump_right,
    input  logic ground,
    input  logic dig,
    output logic walk_left,
    output logic walk_right,
    output logic aaah,
    output logic digging
);

    localparam logic [2:0] WALK_L = 3'd0;
    localparam logic [2:0] WALK_R = 3'd1;
    localparam logic [2:0] FALL_L = 3'd2;
    localparam logic [2:0] FALL_R = 3'd3;
    localparam logic [2:0] DIG_L  = 3'd4;
    localparam logic [2:0] DIG_R  = 3'd5;
    localparam logic [2:0] SPLAT  = 3'd6;

    logic [2:0] state, next_state;
    logic [5:0] fall_count;

    always @(*) begin
        next_state = state;

        case (state)
            WALK_L: begin
                if (!ground)
                    next_state = FALL_L;
                else if (dig)
                    next_state = DIG_L;
                else if (bump_left)
                    next_state = WALK_R;
            end

            WALK_R: begin
                if (!ground)
                    next_state = FALL_R;
                else if (dig)
                    next_state = DIG_R;
                else if (bump_right)
                    next_state = WALK_L;
            end

            DIG_L: begin
                if (!ground)
                    next_state = FALL_L;
            end

            DIG_R: begin
                if (!ground)
                    next_state = FALL_R;
            end

            FALL_L: begin
                if (ground)
                    next_state = (fall_count > 6'd20) ? SPLAT : WALK_L;
            end

            FALL_R: begin
                if (ground)
                    next_state = (fall_count > 6'd20) ? SPLAT : WALK_R;
            end

            SPLAT: begin
                next_state = SPLAT;
            end

            default: begin
                next_state = WALK_L;
            end
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_L;
            fall_count <= 6'd0;
        end else begin
            state <= next_state;

            if ((state == WALK_L || state == WALK_R || state == DIG_L || state == DIG_R) && !ground)
                fall_count <= 6'd1;
            else if ((state == FALL_L || state == FALL_R) && !ground) begin
                if (fall_count < 6'd63)
                    fall_count <= fall_count + 6'd1;
                else
                    fall_count <= fall_count;
            end else if (state == FALL_L || state == FALL_R)
                fall_count <= 6'd0;
            else
                fall_count <= 6'd0;
        end
    end

    assign walk_left  = (state == WALK_L);
    assign walk_right = (state == WALK_R);
    assign aaah       = (state == FALL_L) || (state == FALL_R);
    assign digging    = (state == DIG_L) || (state == DIG_R);

endmodule
