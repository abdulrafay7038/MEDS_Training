module tb;

    logic a, b;

    logic sum_assign, carry_assign;
    logic sum_comb, carry_comb;

    // DUT 1
    half_adder_assign dut_assign (
        .a(a),
        .b(b),
        .sum(sum_assign),
        .carry(carry_assign)
    );

    // DUT 2
    half_adder_comb dut_comb (
        .a(a),
        .b(b),
        .sum(sum_comb),
        .carry(carry_comb)
    );

    initial begin
        // This is a must to include to open the waveform 
        $dumpfile("dump.vcd"); 
        $dumpvars(0, tb); 
        
        $display(" a b | assign(sum,carry) | comb(sum,carry)");

        for (int i = 0; i < 4; i++) begin
            {a, b} = i[1:0];
            #1;

            $display(" %b %b |      %b %b       |    %b %b",
                     a, b,
                     sum_assign, carry_assign,
                     sum_comb, carry_comb);

            if ((sum_assign !== sum_comb) ||
                (carry_assign !== carry_comb))
                $display("FAIL: Outputs do not match!");
            else
                $display("PASS");
        end

        $finish;
    end

endmodule