
module TopModule (
    input  logic        clk,
    input  logic        reset,
    input  logic [7:0]  in,
    output logic [23:0] out_bytes,
    output logic        done
);

    typedef enum logic [1:0] {
        SEARCH,
        BYTE2,
        BYTE3
    } state_t;

    state_t state;
    logic [7:0] byte1;
    logic [7:0] byte2;

    always @(posedge clk) begin
        if (reset) begin
            state <= SEARCH;
            done <= 1'b0;
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            out_bytes <= 24'b0;
        end else begin
            done <= 1'b0;

            case (state)
                SEARCH: begin
                    if (in[3]) begin
                        byte1 <= in;
                        state <= BYTE2;
                    end
                end

                BYTE2: begin
                    byte2 <= in;
                    state <= BYTE3;
                end

                BYTE3: begin
                    out_bytes <= {byte1, byte2, in};
                    done <= 1'b1;

                    if (in[3]) begin
                        byte1 <= in;
                        state <= BYTE2;
                    end else begin
                        state <= SEARCH;
                    end
                end

                default: begin
                    state <= SEARCH;
                end
            endcase
        end
    end

endmodule

