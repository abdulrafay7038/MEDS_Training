module shifter(
    input  logic    shift,
    input  logic  [3:0] w,
    output logic  [3:0] y
    output logic  k;
);  
    assign k = shift?    w[0] : 0;  //shifted out bit

    assign y[0] = shift? w[1] : w[0];
    assign y[1] = shift? w[2] : w[1];
    assign y[2] = shift? w[3] : w[2];
    assign y[3] = shift?   0  : w[3];


endmodule

module barrel_shifter(
    input  logic [3:0] W,
    input  logic [1:0] sel,
    output logic [3:0] Y
);

    always_comb begin

        unique case(sel)

            2'b00:
                Y = W;

            2'b01:
                Y = {W[0], W[3], W[2], W[1]};

            2'b10:
                Y = {W[1], W[0], W[3], W[2]};

            2'b11:
                Y = {W[2], W[1], W[0], W[3]};

        endcase

    end

endmodule


module mux2to1(
    input  logic in0, in1,
    input  logic sel,
    output logic out
);

    assign out = sel ? in1 : in0;

endmodule