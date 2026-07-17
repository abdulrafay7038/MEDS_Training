module tb; 
    logic a, b, x, y, z; 
    logic [2:0] ab;
  
    gates dut (.a(a), .b(b), .y(y), .x(x), .z(z)); 
  
  	task automatic check(input logic actual, expected, string name); 
          if (actual !== expected) 
              $display("[FAIL] %s: expected=%0b actual=%0b", name, expected, actual); 
          else 
              $display("[PASS] %s: value=%0b", name, actual); 
    endtask 
      
	function automatic logic expected_and(input logic a, b); 
        return (a & b);   
    endfunction 
    function automatic logic expected_or(input logic a, b); 
        return (a | b);   
    endfunction
    function automatic logic expected_xor(input logic a, b); 
        return (a ^ b);   
    endfunction 
      
    initial begin 
        // This is a must to include to open the waveform 
        $dumpfile("dump.vcd"); 
        $dumpvars(0, tb); 
         for (ab = 2'b00; ab <= 2'b11; ab = ab + 1) begin 
              {a, b} = ab;           // unpack the loop variable onto the 3 inputs 
              #1;                        // let combinational logic settle 
           check(y, expected_and(a, b), $sformatf("ab=%02b AND", ab));
           check(z, expected_xor(a, b), $sformatf("ab=%02b XOR", ab));
           check(x, expected_or(a, b), $sformatf("ab=%02b OR", ab));
           check(y, 1, $sformatf("ab=%02b", ab)); //Intentional
          end 
          $finish; 
    end
  	
endmodule 
