module divider(
    input logic clk,
    input logic reset,
    output logic clk_out
);
    logic [3:0] counter;
    assign rst = (counter == 10);
  
    always_ff @(posedge clk) begin
      if (rst || reset) begin
            counter <= 0;
      end
        else begin
            counter <= counter + 1;    
        end
    end
    assign clk_out = (counter == 0);
  
endmodule