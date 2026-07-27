//Aurthor: Abdul Rafay
//Written by hand
`include "cache.svh"  //all parameters coming from here!
module top(
    input logic clk,
    input logic rst,

    input logic  [ADDR_WIDTH-1:0] address,
    input logic  [DATA_WIDTH-1:0] data_in,
    input logic                   req_valid,
    input logic                   req_type,  //1 = write, 0 = read

    output logic [DATA_WIDTH-1:0] data_out,
    output logic                  done,
    output logic                  hit,
    output logic                  miss
);

    //----------Cache Decoder------------//
    logic [TAG_WIDTH-1:0]    tag;
    logic [INDEX_WIDTH-1:0]  index;
    logic [OFFSET_WIDTH-1:0] offset;

    cache_decoder Decoder(
        .address(address),
        .tag(tag),
        .index(index),
        .offset(offset)
    );

    //----------Cache Memory------------//
    logic                 wr_en, rd_en;
    cache_mem Memory(
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .tag(tag),
        .index(index),
        .offset(offset),
        .data_out(data_out),
        .hit(hit)
    );

    //----------Cache Controller------------//
    
    cache_controller Controller(
        .clk(clk),
        .rst(rst),
        .req_valid(req_valid),
        .req_type(req_type),
        .hit(hit),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .done(done)
    );
    assign miss = !hit;

endmodule