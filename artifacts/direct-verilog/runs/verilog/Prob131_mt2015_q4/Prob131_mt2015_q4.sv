
module A (
    input  logic x,
    input  logic y,
    output logic z
);
    assign z = (x ^ y) & x;
endmodule

module B (
    input  logic x,
    input  logic y,
    output logic z
);
    assign z = ~(x ^ y);
endmodule

module top_module (
    input  logic x,
    input  logic y,
    output logic z
);
    logic a1_z;
    logic a2_z;
    logic b1_z;
    logic b2_z;
    logic or_z;
    logic and_z;

    A a1 (
        .x(x),
        .y(y),
        .z(a1_z)
    );

    B b1 (
        .x(x),
        .y(y),
        .z(b1_z)
    );

    A a2 (
        .x(x),
        .y(y),
        .z(a2_z)
    );

    B b2 (
        .x(x),
        .y(y),
        .z(b2_z)
    );

    assign or_z = a1_z | b1_z;
    assign and_z = a2_z & b2_z;
    assign z = or_z ^ and_z;
endmodule

