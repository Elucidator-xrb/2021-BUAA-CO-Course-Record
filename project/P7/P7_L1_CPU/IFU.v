`timescale 1ns / 1ps

module IFU(
    input Clk,
    input Rst,
	 input We,
	 input [31:0] NPC,
	 
	 output ExcAdEL,
    output [31:0] PC_out
    );
	reg [31:0] PC;
	
	assign ExcAdEL = (PC < 32'h0000_3000) |
						  (PC > 32'h0000_4fff) | 
						  (|PC[1:0]) ; //ÉÐÎ´¿¼ÂÇeretµÄÊÂÇé
						  
	assign PC_out = PC ;

	always @(posedge Clk) begin
		if(Rst == 1) begin
			PC <= 32'h0000_3000;
		end else if(We == 1) begin
			PC <= NPC;
		end
	end
	
	initial begin
		PC = 32'h0000_3000;
	end

endmodule
