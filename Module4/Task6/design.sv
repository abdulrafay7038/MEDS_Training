module decoder2to4 ( 
    input  logic       en, 
    input  logic [1:0] sel, 
    output logic [3:0] y 
); 
    always_comb begin 
        if (!en) 
            y = 4'b0000;          // disabled: every output forced low 
        else begin 
            case (sel) 
                2'b00: y = 4'b0001; 
                2'b01: y = 4'b0010; 
                2'b10: y = 4'b0100; 
                2'b11: y = 4'b1000; 
                default: y = 4'b0000; 
            endcase 
        end 
    end 
endmodule 

module decoder3to8(
    input  logic       en,
    input  logic [2:0] sel,
    output logic [7:0] y
);
    logic [3:0] y1, y2;
    
    decoder2to4 D1(
        .en(sel[2]),
        .sel(sel[1:0]),
        .y(y1)
    );

    decoder2to4 D2(
        .en(~sel[2]),
        .sel(sel[1:0]),
        .y(y2)
    );

  assign y = en? {y1,y2} : 8'b00000000;

endmodule