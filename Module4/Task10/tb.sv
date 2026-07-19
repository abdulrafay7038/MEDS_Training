module updown_counter_tb;

    logic clk;
    logic rst_n;
    logic up_down;
    logic [3:0] count;

    updown_counter DUT(
        .clk(clk),
        .rst_n(rst_n),
        .up_down(up_down),
        .count(count)
    );

    // 10 ns clock
    initial clk = 0;
    always #5 clk = ~clk;

    task check(input logic [3:0] expected);
        #1;
        if (count === expected)
            $display("PASS: count=%0d", count);
        else
            $display("FAIL: expected=%0d got=%0d", expected, count);
    endtask

    initial begin

        $dumpfile("counter.vcd");
        $dumpvars(0, updown_counter_tb);

        //-------------------------
        // Initial Reset
        //-------------------------
        rst_n = 0;
        up_down = 1;

        #2;
        check(0);

        rst_n = 1;

        //-------------------------
        // Count Up
        //-------------------------
        repeat(5) begin
            @(posedge clk);
            check(count);
        end

        //-------------------------
        // Assert reset mid-count
        //-------------------------
        #3;
        rst_n = 0;

        #1;
        if (count == 0)
            $display("PASS: Asynchronous reset works.");
        else
            $display("FAIL: Reset did not clear immediately.");

        //-------------------------
        // Release reset
        //-------------------------
        #6;
        rst_n = 1;

        //-------------------------
        // Count Up to Wraparound
        //-------------------------
        up_down = 1;

        repeat(17)
            @(posedge clk);

        check(1);   // 0→...→15→0→1

        //-------------------------
        // Count Down to Wraparound
        //-------------------------
        up_down = 0;

        repeat(3)
            @(posedge clk);

        check(14);  // 1→0→15→14

        $finish;

    end

endmodule