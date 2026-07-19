module reset_synchronizer_tb;

    logic clk;
    logic rst_n_async;
    logic rst_n_sync;

    reset_synchronizer DUT(
        .clk(clk),
        .rst_n_async(rst_n_async),
        .rst_n_sync(rst_n_sync)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin

        $dumpfile("reset_sync.vcd");
        $dumpvars(0, reset_synchronizer_tb);

        // Initially in reset
        rst_n_async = 0;

        #12;
        rst_n_async = 1;   // release between clocks

        #30;

        rst_n_async = 0;   // assert asynchronously

        #3;
        rst_n_async = 1;   // release shortly before edge

        #25;

        rst_n_async = 0;

        #5;                // release exactly at clock edge
        rst_n_async = 1;

        #30;

        $finish;

    end

endmodule