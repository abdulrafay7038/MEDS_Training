`ifndef CACHE_SVH
`define CACHE_SVH

// Cache Parameters
parameter int ADDR_WIDTH      = 16;
parameter int DATA_WIDTH      = 32;

// One cache line = 4 32-bit words
parameter int WORDS_PER_BLOCK  = 4;

// Number of cache lines
parameter int NUM_BLOCKS       = 16;

// Derived Parameters
parameter int INDEX_WIDTH      = $clog2(NUM_BLOCKS);                         // 4
parameter int OFFSET_WIDTH     = $clog2(WORDS_PER_BLOCK);                    // 2 (4 bytes)
parameter int TAG_WIDTH        = ADDR_WIDTH - INDEX_WIDTH - OFFSET_WIDTH;    // 10

`endif