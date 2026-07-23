module stopwatch_tb;

    logic clk;
    logic clr;

    logic [3:0] tenth_second;
    logic [5:0] second;
    logic [3:0] minute;

    stopwatch DUT(
        .clk(clk),
        .clr(clr),
        .tenth_second(tenth_second),
        .second(second),
        .minute(minute)
    );

    // 100 MHz clock (10 ns period)
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin

        $dumpfile("stopwatch.vcd");
        $dumpvars(0, stopwatch_tb);

        clr = 1;
        #20;
        clr = 0;

        // Run for 60 seconds of simulation time
        #60s;

        $display("--------------------------------");
        $display("Minute = %0d", minute);
        $display("Second = %0d", second);
        $display("Tenth  = %0d", tenth_second);
        $display("--------------------------------");

        if (minute == 1 && second == 0 && tenth_second == 0)
            $display("PASS");
        else
            $display("FAIL");

        $finish;
    end

endmodule