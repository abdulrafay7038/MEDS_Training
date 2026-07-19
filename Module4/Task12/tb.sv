module divider_tb();

    logic clk, reset, clk_out;
    logic [3:0] counter = 0;
	
  	initial clk = 1;
    always #5 clk = ~clk;

    divider UUT(
        .clk(clk),
        .reset(reset),
        .clk_out(clk_out)
    );

    initial begin
        $dumpfile("divider.vcd");
        $dumpvars(0, divider_tb);
        reset = 1;
        #5 reset = 0;
        if(!clk_out) 
            counter = counter + 1;
        else
            counter = 0; 
      	#250;
        $finish;
    end

endmodule