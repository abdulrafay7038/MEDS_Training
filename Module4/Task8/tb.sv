module m12367_tb();

    logic a,b,c,F;

    m12367 uut(
        .a(a),
        .b(b),
        .c(c),
        .F(F)
    );

    initial begin
        // This is a must to include to open the waveform 
        $dumpfile("dump.vcd"); 
        $dumpvars(0, m12367_tb); 

        for (int i = 0; i < 8 ; i++) begin
            {a,b,c} = i[2:0];
            #5;
            $display("For abc = %03b, F = %0b", {a,b,c}, F);
        end
    end


endmodule