module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic out_sop,
    output logic out_pos
);

    assign out_sop = (c & d) | (c & ~a & ~b);
    assign out_pos = c & (b | ~a) & (d | ~b);

endmodule
