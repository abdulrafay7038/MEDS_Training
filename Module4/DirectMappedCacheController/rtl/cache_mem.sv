//Aurthor: Abdul Rafay
//Written by hand
`include "cache.svh"  //all parameters coming from here!
module cache_mem(
    input logic                          clk,
    input logic                          rst,

    input logic    [DATA_WIDTH-1:0]      data_in,
    input logic                          wr_en,
    input logic                          rd_en,
    
    input logic    [TAG_WIDTH-1:0]       tag,
    input logic    [INDEX_WIDTH-1:0]     index,
    input logic    [OFFSET_WIDTH-1:0]    offset,
    

    output logic   [DATA_WIDTH-1:0]      data_out,
    output logic                         hit

);

    //Arrays for Storage!
    logic [WORDS_PER_BLOCK-1:0][DATA_WIDTH-1:0] data_array  [NUM_BLOCKS-1:0];      //Vector Subfield we studied in DSD!
    logic [TAG_WIDTH-1:0]                       tag_array   [NUM_BLOCKS-1:0];
    logic                                       valid_array [NUM_BLOCKS-1:0];


    always_ff @(posedge clk or posedge rst) begin 
        if (rst) begin
            data_out <= 0;
            for(int i = 0; i < NUM_BLOCKS; i++)  //Initialize all valids
                valid_array[i] <= 0;
        end
        else if (rd_en)
            data_out <= data_array[index][offset];  

        else if (wr_en) begin
            data_array[index][offset] <= data_in;
            valid_array[index]        <=  1;
            tag_array[index]          <=  tag;
        end
    end
    assign hit = valid_array[index] && (tag == tag_array[index]);

endmodule