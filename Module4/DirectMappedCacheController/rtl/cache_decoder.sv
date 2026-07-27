//Aurthor: Abdul Rafay
//Written by hand
`include "cache.svh"  //all parameters coming from here!
module cache_decoder(
    input  logic    [ADDR_WIDTH-1:0]      address,
    output logic    [TAG_WIDTH-1:0]       tag,
    output logic    [INDEX_WIDTH-1:0]     index,
    output logic    [OFFSET_WIDTH-1:0]    offset      
);

assign tag    = address[ADDR_WIDTH-1:ADDR_WIDTH-TAG_WIDTH];
assign index  = address[ADDR_WIDTH-TAG_WIDTH-1:OFFSET_WIDTH];
assign offset = address[OFFSET_WIDTH-1:0];

endmodule 