module fixed_shift_tb;

    logic [3:0] W;
    logic shift;

    logic [3:0] Y;
    logic k;

    fixed_shift DUT(
        .W(W),
        .shift(shift),
        .Y(Y),
        .k(k)
    );

    initial begin

        $dumpfile("shift.vcd");
        $dumpvars(0,fixed_shift_tb);

        W = 4'b0000;
        shift = 0; #10;
        shift = 1; #10;

        W = 4'b1010;
        shift = 0; #10;
        shift = 1; #10;

        W = 4'b1101;
        shift = 0; #10;
        shift = 1; #10;

        W = 4'b0111;
        shift = 0; #10;
        shift = 1; #10;

        $finish;

    end

endmodule

module barrel_tb;

    logic [3:0] W;
    logic [1:0] sel;

    logic [3:0] Y;

    barrel_shifter DUT(
        .W(W),
        .sel(sel),
        .Y(Y)
    );

    initial begin

        $dumpfile("barrel.vcd");
        $dumpvars(0,barrel_tb);

        W = 4'b1010;
        for(int i=0;i<4;i++) begin
            sel = i;
            #10;
        end

        W = 4'b1101;
        for(int i=0;i<4;i++) begin
            sel = i;
            #10;
        end

        W = 4'b0111;
        for(int i=0;i<4;i++) begin
            sel = i;
            #10;
        end

        $finish;

    end

endmodule