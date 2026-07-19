module majority3(
    input  logic a, b, c,
    output logic F
);

    logic bc;
    logic borc;

    // bc = b ? c : 0
    mux2to1 M1(
        .sel(b),
        .in0(1'b0),
        .in1(c),
        .out(bc)
    );

    // b+c = b ? 1 : c
    mux2to1 M2(
        .sel(b),
        .in0(c),
        .in1(1'b1),
        .out(borc)
    );

    // F = a ? (b+c) : bc
    mux2to1 M3(
        .sel(a),
        .in0(bc),
        .in1(borc),
        .out(F)
    );

endmodule

module m12367(
    input  logic a,b,c,
    output logic F
);
    mux4to1 M(
        .sel({a,b}),
        .in0(c),
        .in1(1),
        .in2(0),
        .in3(1),
        .out(F)
    );

endmodule

module mux2to1(
    input  logic in0, in1,
    input  logic sel,
    output logic out
);

    assign out = sel ? in1 : in0;

endmodule

module mux4to1(
    input  logic in0,in1,in2,in3,
    input  logic [1:0] sel,
    output logic out
);

    always_comb begin
        case(sel) 
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            2'b11: out = in3;
        endcase
    end

endmodule