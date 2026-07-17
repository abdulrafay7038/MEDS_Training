module parity(
    input  logic [3:0] in,
    output logic       out

);
    assign out = ^in;
endmodule