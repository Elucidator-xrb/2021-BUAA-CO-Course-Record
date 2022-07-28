`timescale 1ns / 1ps

module code(
    input Clk,
    input Reset,
    input Slt,
    input En,
    output reg [63:0] Output0 = 0,
    output reg [63:0] Output1 = 0
	 );
	reg [1:0] tmp = 0;
	 
	always @(posedge Clk) begin
		case(Reset)
      1'b1 : begin
						Output0 <= 0;
						Output1 <= 0;
				 end
      1'b0 : begin
                  if(Slt == 0 && En) Output0 <= Output0 + 1;
                  else if(Slt == 1 && En) begin
							tmp = tmp + 1;
							if(tmp == 0) Output1 <= Output1 + 1;
						end
						
             end 
		endcase 
	end
	
endmodule