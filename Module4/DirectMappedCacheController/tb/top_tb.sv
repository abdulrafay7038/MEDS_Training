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
        .miss(miss)
    );

    initial   clk = 1;
    always #5 clk = ~clk;

    initial begin     
$display("Writing data to an empty cache line. ");
        req_type = 1;                              //Write req
        data_in = 32;
        address = 16'b1101101100_0001_00;          //tag_index_offset
        req_valid = 0;
        rst = 1;
        #10 rst = 0; req_valid = 1;
        #10 req_valid = 0;
        @(posedge done);
        #10;

$display("Reading the same address and verifying a cache hit");
        req_type = 0; req_valid = 1;                //Read req
        #10 req_valid = 0;
        @(posedge done);
        #5;
        if (UUT.hit) begin
            if (data_out == 32'd32)
                $display("PASS: Cache Hit! Read data = %0d", data_out);
            else 
                $display("FAIL: Cache Hit but data doesn't match, expected = 32, actual = %0d", data_out);
        end    
        else
            $display("FAIL: No hit");   

$display("Reading a different address that maps to an empty line (cache miss)");
        @(posedge clk) req_valid = 1;
        address = 16'b1111111100_0010_00;    //tag_index_offset
        #10 req_valid = 0;
        #15;
        if (miss) 
            $display("PASS: Cache Miss!");       
        else
            $display("FAIL: Cache Miss couldn't be verified");  

$display("Accessing two addresses that map to the same index but have different tags and verifying correct cache behavior.");
            //First 
            
            repeat(2)@(posedge clk) req_valid = 1;
            address = 16'b1101101100_0001_00;
            #10 req_valid = 0;
            @(posedge done);
            #5;
            if (UUT.hit) begin
                if (data_out == 32'd32)
                    $display("PASS: Cache Hit!");
                else 
                    $display("FAIL: Cache Hit but data doesn't match, expected = 32, actual = %d", data_out);
            end    
            else
                $display("FAIL: No hit"); 
            //Second    
            @(posedge clk) req_valid = 1;
            address = 16'b0000001100_0001_00;
            #10 req_valid = 0;
            @(posedge miss);
            if (miss) begin
                $display("PASS: Cache Miss!"); 
            end         
            else
                $display("FAIL: Cache Miss couldn't be verified");    
        $finish;
  
    end


endmodule

