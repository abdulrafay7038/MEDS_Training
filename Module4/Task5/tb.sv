module tb();
    logic [3:0] in;
    logic out;

    parity UUT(
        .in(in),
        .out(out)
    );
    
    initial begin
        // This is a must to include to open the waveform 
        $dumpfile("dump.vcd"); 
        $dumpvars(0, tb); 

        for (int i = 0; i < 16; i++) begin
            in = i[3:0];
			#5;
          if(out == ($countones(in)%2 != 0)) $display("PASS! for in: %04b", in);
          else $display("FAIL! for in: %04b", in);

        end
    end
    
endmodule