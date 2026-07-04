
module TopModule (
    input  logic       clk,
    input  logic       reset,
    input  logic [7:0] in,
    output logic       done
);

    logic [1:0] state;
    logic [1:0] next_state;

    always @(*) begin
        case (state)
            2'd0: next_state = in[3] ? 2'd1 : 2'd0;
            2'd1: next_state = 2'd2;
            2'd2: next_state = 2'd3;
            2'd3: next_state = in[3] ? 2'd1 : 2'd0;
            default: next_state = 2'd0;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            state <= 2'd0;
        else
            state <= next_state;
    end

    assign done = (state == 2'd3);

endmodule

