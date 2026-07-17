module decoder_tb();
    logic en; 
    logic [2:0] sel; 
    logic [7:0] out;

    decoder3to8 UUT(
        .en(en),
        .sel(sel),
        .y(out)
    );

    initial begin
        // This is a must to include to open the waveform 
        $dumpfile("dump.vcd"); 
        $dumpvars(0, decoder_tb); 
        en = 1;
        #5;
        for (int i = 0; i < 8; i++) begin
            sel = i[2:0];
			#5;
          if(out[sel] == 1) $display("PASS! for sel : %03b out : %08b", sel, out);
          else $display("FAIL! for sel : %03b out : %08b", sel, out);
        end
        en = 0;
        #5;
        for (int i = 0; i < 8; i++) begin
            sel = i[2:0];
			#5;
          if(out == 8'd0) $display("PASS! for en : %0b out : %08b", en, out);
          else $display("FAIL! for en : %0b out : %08b", en, out);
        end
    end

endmodule