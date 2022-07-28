`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:28:05 11/20/2021 
// Design Name: 
// Module Name:    D_REG 
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
module D_REG(
    input Clk,
    input Rst,
    input We,
    input [31:0] IR_in,
    input [31:0] PC_in,
    output reg [31:0] IR_out,
    output reg [31:0] PC_out
    );

	always @(posedge Clk) begin
		if(Rst == 1) begin
			IR_out <= 0;
			PC_out <= 0;
		end else if(We == 1) begin
			IR_out <= IR_in;
			PC_out <= PC_in;
		end
	end
	
	initial begin
		IR_out = 0;
		PC_out = 0;
	end

endmodule
