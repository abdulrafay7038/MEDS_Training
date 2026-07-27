//Aurthor: Abdul Rafay
//Written by hand
`include "cache.svh"  //all parameters coming from here!
module top_tb();

    logic                          clk; 
    logic                          rst;   
    logic    [ADDR_WIDTH-1:0]      address; 
    logic    [DATA_WIDTH-1:0]      data_in;
    logic                          req_type;  //1 = write, 0 = read
    logic                          req_valid;
    logic    [DATA_WIDTH-1:0]      data_out;
    logic                          hit;
    logic                          miss;
    logic                          done;

    top UUT(
        .clk(clk),
        .rst(rst),
        .address(address),
        .data_in(data_in),
        .req_type(req_type),
        .req_valid(req_valid),
        .data_out(data_out),
        .done(done),
        .miss(miss),
        .hit(hit)
    );

    initial   clk = 1;
    always #5 clk = ~clk;

    task write_cache(input logic [15:0] addr, input logic [31:0] data);
        req_type = 1;           //Write req
        data_in = data;
        address = addr;
        req_valid = 1;
        @(posedge clk) req_valid = 0;
        @(negedge done);        //let the FSM get done
    endtask

    task read_cache(input logic [15:0] addr);
        req_type = 0;           //Read req
        address = addr;
        req_valid = 1;
        @(posedge clk) req_valid = 0;
        @(negedge done);       // wait for controller to finish read
    endtask

    task verify_hit(input logic [15:0] addr, input logic [31:0] expected);
        read_cache(addr);
        if (UUT.hit) begin
            if (data_out == expected)
                $display("[PASS]: Cache Hit! Expected = %0d, Actual = %0d", expected, data_out);
            else 
                $display("[FAIL]: Cache Hit but data doesn't match, Expected = 32, Actual = %0d", expected, data_out);
        end 
        else
            $display("[FAIL]: Cache Hit couldn't be verified");  
    endtask

    task verify_miss(input logic [15:0] addr);
        read_cache(addr);
        if (miss) 
            $display("[PASS]: Cache Miss!");       
        else
            $display("[FAIL]: Cache Miss couldn't be verified"); 
    endtask

    initial begin    

        $display("==================================================");    
        $display("Writing data to an empty cache line. ");
        $display("==================================================");
        rst = 1; @(posedge clk) rst = 0; 
        write_cache(16'b0000001100_0001_00, 32'd32); 
        write_cache(16'b0000001100_0001_01, 32'd33);  
        write_cache(16'b0000001100_0001_10, 32'd34);
        write_cache(16'b0000001100_0001_11, 32'd35);
        $display("==================================================");
        $display("Reading the same address and verifying a cache hit");
        $display("==================================================");
        verify_hit(16'b0000001100_0001_00, 32'd32);  
        verify_hit(16'b0000001100_0001_01, 32'd33); 
        verify_hit(16'b0000001100_0001_10, 32'd34); 
        verify_hit(16'b0000001100_0001_11, 32'd35); 
        $display("===================================================================");
        $display("Reading a different address that maps to an empty line (cache miss)");
        $display("===================================================================");
        verify_miss(16'b1110001100_0010_00);
        $display("================================================================================================================");
        $display("Accessing two addresses that map to the same index but have different tags and verifying correct cache behavior.");
        $display("================================================================================================================");
            
        $display("-----------First------------");
        verify_hit(16'b0000001100_0001_11, 32'd35);
        $display("-----------Second------------");   
        verify_miss(16'b1101101100_0001_00);

        $display("==========================================");
        $display("Writing more cache lines and verifying hit");
        $display("==========================================");
        write_cache(16'b0001111100_0010_00, 32'd75); 
        write_cache(16'b0001111100_0010_01, 32'd78);  
        write_cache(16'b0001111100_0010_10, 32'd76);
        write_cache(16'b0001111100_0010_11, 32'd91);

        verify_hit(16'b0001111100_0010_00, 32'd75); 
        verify_hit(16'b0001111100_0010_01, 32'd78);  
        verify_hit(16'b0001111100_0010_10, 32'd76);
        verify_hit(16'b0001111100_0010_11, 32'd91);

        write_cache(16'b1001111100_0011_00, 32'd92); 
        write_cache(16'b1001111100_0011_01, 32'd93);  
        write_cache(16'b1001111100_0011_10, 32'd94);
        write_cache(16'b1001111100_0011_11, 32'd95);

        verify_hit(16'b1001111100_0011_00, 32'd92); 
        verify_hit(16'b1001111100_0011_01, 32'd93);  
        verify_hit(16'b1001111100_0011_10, 32'd94);
        verify_hit(16'b1001111100_0011_11, 32'd95);

        $finish;
  
    end


endmodule

