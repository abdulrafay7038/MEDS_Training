`ifndef CACHE_SVH
`define CACHE_SVH

// Cache Parameters
parameter int ADDR_WIDTH      = 16;
parameter int DATA_WIDTH      = 32;

// One cache line = one 32-bit word
parameter int WORDS_PER_BLOCK  = 1;
parameter int WORD_SIZE        = DATA_WIDTH;

// Number of cache lines
parameter int NUM_BLOCKS       = 16;

// Derived Parameters
parameter int BLOCK_SIZE       = WORDS_PER_BLOCK * WORD_SIZE;     // 32 bits
parameter int CACHE_SIZE       = (NUM_BLOCKS * BLOCK_SIZE) / 8;   // 64 Bytes

parameter int INDEX_WIDTH      = $clog2(NUM_BLOCKS);                       // 4
parameter int OFFSET_WIDTH     = $clog2(DATA_WIDTH/8);                     // 2 (4 bytes)
parameter int TAG_WIDTH        = ADDR_WIDTH - INDEX_WIDTH - OFFSET_WIDTH;  // 10

`endif