module reset_synchronizer(
    input  logic clk,
    input  logic rst_n_async,
    output logic rst_n_sync
);

    logic q1;

    dff_async_rst FF1(
        .clk(clk),
        .rst_n(rst_n_async),
        .d(1'b1),
        .q(q1)
    );

    dff_async_rst FF2(
        .clk(clk),
        .rst_n(rst_n_async),
        .d(q1),
        .q(rst_n_sync)
    );

endmodule

module dff_async_rst(
    input  logic clk,
    input  logic rst_n,
    input  logic d,
    output logic q
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule