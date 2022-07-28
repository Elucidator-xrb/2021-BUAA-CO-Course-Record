`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:51:02 11/20/2021 
// Design Name: 
// Module Name:    IFU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////


module IFU(
    input Clk,
    input Rst,
	 input We,
	 input [31:0] NPC,
    output [31:0] PC_out,
    output [31:0] IM_D
    );
	reg [31:0] PC;
	reg [31:0] IM[0:4095];
	integer i;
	
	assign PC_out = PC ;
	assign IM_D = IM[(PC-32'h00003000)/4];

	always @(posedge Clk) begin
		if(Rst == 1) begin
			PC <= 32'h0000_3000;
		end else if(We == 1) begin
			PC <= NPC;
		end
	end
	
	initial begin
		PC = 32'h0000_3000;
		for(i=0;i<4096;i=i+1)
			IM[i] = 32'h0000_0000;
		$readmemh("code.txt",IM);
	end

endmodule
