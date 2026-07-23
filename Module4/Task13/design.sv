module stopwatch #(parameter N = 4)
  (
    input   logic clk,
    input   logic clr,

    output  logic [3:0] tenth_second,
    output  logic [5:0] second,
    output  logic [3:0] minute
);
   

  logic [N-1:0] count;
   logic clk_out;

   always_ff @(posedge clk) begin
        if (clr)
            count <= 0;
        else    

            count <= count + 1;    
   end

   assign clk_out = (count == 0);

   always_ff @(posedge clk) begin
        if (clr) 
            tenth_second <= 0;
        else if (clk_out) begin
            if (tenth_second == 9)
                tenth_second <= 0;
            else
                tenth_second <= tenth_second + 1;  
        end          
   end

   always_ff @(posedge clk) begin
        if (clr) 
            second <= 0;
        else if (tenth_second == 9 && clk_out) begin
            if (second == 59)
                second <= 0;
            else
                second <= second + 1; 
        end     
   end

    always_ff @(posedge clk) begin
        if (clr)
            minute <= 0;
        else if (clk_out && tenth_second == 9 && second == 59) begin
            if (minute == 9)
                minute <= 0;
            else
                minute <= minute + 1;
    end
end

endmodule