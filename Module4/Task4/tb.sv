module tb();
    logic a, b, c, d, f0, f1;

    circuit UUT(
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .f0(f0),
        .f1(f1)
    );
    
    initial begin
        // This is a must to include to open the waveform 
        $dumpfile("dump.vcd"); 
        $dumpvars(0, tb); 

        for (int i = 0; i < 16; i++) begin
            {a,b,c,d} = i[3:0];
			#5;
            if(f0 == f1) $display("PASS! for abcd: %04b", {a,b,c,d});
            else $display("FAIL! for abcd: %0b", {a,b,c,d});

        end
    end
    
endmodule