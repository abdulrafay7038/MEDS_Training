//Simple one
module LZC(
    input  logic [31:0] in,
    output logic [5:0] count
);
    always_comb begin
        count = 0;
        for (int i = 31; i >=0 ; i++) begin
            if (in[i] == 0) count = count + 1;
            else if (in[i] == 1) break;
        end
    end

endmodule