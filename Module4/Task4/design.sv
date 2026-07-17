module circuit(
    input logic a,b,c,d,
    output logic f0,f1
);

    assign f0 = ((b | c | d) & (~a | b | c) & (~a | d));             //AND-OR Network
    logic x, y, z;

    assign x = ~(b | c | d);
    assign y = ~(~a | b | c);
    assign z = ~(~a | d);

    assign f1 = ~(x | y | z);                                    //NOR Network

endmodule