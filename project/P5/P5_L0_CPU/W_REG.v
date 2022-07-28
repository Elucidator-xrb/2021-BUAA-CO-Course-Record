`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:41:38 11/20/2021 
// Design Name: 
// Module Name:    W_REG 
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
module W_REG(
    input Clk,
    input Rst,
    input We,
    input [31:0] IR_in,
    input [31:0] PC_in,
    input [31:0] DR_in,
    input [31:0] Y_in,
	 input [1:0] ACmpB_in,
	 input [1:0] ACmp0_in,
    output reg [31:0] IR_out,
    output reg [31:0] PC_out,
    output reg [31:0] DR_out,
    output reg [31:0] Y_out,
	 output reg [1:0] ACmpB_out,
	 output reg [1:0] ACmp0_out
    );

	always @(posedge Clk) begin
		if(Rst == 1) begin
			IR_out <= 0;
			PC_out <= 0;
			DR_out <= 0;
			Y_out  <= 0;
			ACmpB_out <= 0;
			ACmp0_out <= 0;
		end else if(We == 1) begin
			IR_out <= IR_in;
			PC_out <= PC_in;
			DR_out <= DR_in;
			Y_out  <= Y_in ;
			ACmpB_out <= ACmpB_in;
			ACmp0_out <= ACmp0_in;
		end
	end

	initial begin 
			IR_out = 0;
			PC_out = 0;
			DR_out = 0;
			Y_out  = 0;
			ACmpB_out = 0;
			ACmp0_out = 0;
	end
	
endmodule
