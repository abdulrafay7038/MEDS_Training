//Aurthor: Abdul Rafay
//Written by hand
`include "cache.svh"  //all parameters coming from here!
module cache_controller(
    input logic                          clk,   
    input logic                          rst,
    input logic                          req_type, //1 = write, 0 = read
    input logic                          req_valid,          
    input logic                          hit,

    output logic                         rd_en,
    output logic                         wr_en,
    output logic                         miss,
    output logic                         done
);
    
    typedef enum logic [2:0] {IDLE, READ, WRITE, MISS, DONE} state;
    state PS,NS;

    //State Register
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            PS <= IDLE;
        else    
            PS <= NS;    
    end

    //Next State Logic
    always_comb begin
        case(PS)
            IDLE: begin
                if (req_valid)
                    NS = req_type ? WRITE : READ;  
                else
                    NS = IDLE;      
            end
            READ:  NS = hit ? DONE: MISS;
            WRITE: NS = DONE;
            MISS:  NS = DONE;
            DONE:  NS = IDLE;
        endcase
    end

    //Output Logic
    always_comb begin
        case (PS)
            IDLE: begin
                rd_en = 0;
                wr_en = 0;
                done  = 0;
                miss  = 0;
            end
            READ: begin
                rd_en = hit ? 1 : 0;
                wr_en = 0;
                done  = 0;
                miss  = 0;
            end
            WRITE: begin
                rd_en = 0;
                wr_en = 1;
                done  = 0;
                miss  = 0;
            end
            MISS: begin
                rd_en = 0;
                wr_en = 0;
                done  = 0;
                miss  = 1;
            end
            DONE: begin
                rd_en = 0;
                wr_en = 0;
                done  = 1;
                miss  = 0;
            end
        endcase
    end

endmodule