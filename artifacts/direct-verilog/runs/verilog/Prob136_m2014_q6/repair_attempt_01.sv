module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic w,
    output logic z
);

    localparam logic [2:0] A = 3'd0;
    localparam logic [2:0] B = 3'd1;
    localparam logic [2:0] C = 3'd2;
    localparam logic [2:0] D = 3'd3;
    localparam logic [2:0] E = 3'd4;
    localparam logic [2:0] F = 3'd5;

    logic [2:0] state;
    logic [2:0] next_state;

    always_comb begin
        case (state)
            A: next_state = w ? A : B;
            B: next_state = w ? D : C;
            C: next_state = w ? D : E;
            D: next_state = w ? A : F;
            E: next_state = w ? D : E;
            F: next_state = w ? D : C;
            default: next_state = A;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    assign z = (state == E) || (state == F);

endmodule
