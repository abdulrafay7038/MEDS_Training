module full_adder(
    input  logic a,
    input  logic b,
    input  logic cin,
    output logic sum,
    output logic cout
);

    logic s1;
    logic c1;
    logic c2;

    half_adder_assign HA1 (
        .a(a),
        .b(b),
        .sum(s1),
        .carry(c1)
    );

    half_adder_assign HA2 (
        .a(s1),
        .b(cin),
        .sum(sum),
        .carry(c2)
    );

    assign cout = c1 | c2;

endmodule

module half_adder_assign(
    input  logic a,
    input  logic b,
    output logic sum,
    output logic carry
);

    assign sum   = a ^ b;
    assign carry = a & b;

endmodule

module half_adder_comb(
    input  logic a,
    input  logic b,
    output logic sum,
    output logic carry
);

    always_comb begin
        if (a == b)
            sum = 0;
        else
            sum = 1;

        if (a && b)
            carry = 1;
        else
            carry = 0;
    end

endmodule