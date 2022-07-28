`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:18:13 11/20/2021 
// Design Name: 
// Module Name:    M_REG 
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
module M_REG(
    input Clk,
    input Rst,
    input We,
	 input Req,
	 input BD_in,
    input [31:0] IR_in,
    input [31:0] PC_in,
    input [31:0] Y_in,
    input [31:0] V2_in,
	 input [31:0] HILO_in,
	 input [4:0] ExcCode_in,
	 input [1:0] ACmpB_in,
	 input [1:0] ACmp0_in,
	 output reg BD_out,
    output reg [31:0] IR_out,
    output reg [31:0] PC_out,
    output reg [31:0] Y_out,
    output reg [31:0] V2_out,
	 output reg [31:0] HILO_out,
	 output reg [4:0] ExcCode_out,
	 output reg [1:0] ACmpB_out,
	 output reg [1:0] ACmp0_out
    );
	
	always @(posedge Clk) begin
		if(Rst | Req) begin
			BD_out <= 0;
			IR_out <= 0;
			PC_out <= 0;
			Y_out  <= 0;
			V2_out <= 0;
			HILO_out <= 0;
			ExcCode_out <= 5'd31;
			ACmpB_out <= 0;
			ACmp0_out <= 0;
		end else if(We == 1) begin
			BD_out <= BD_in;
			IR_out <= IR_in;
			PC_out <= PC_in;
			Y_out  <= Y_in ;
			V2_out <= V2_in;
			HILO_out <= HILO_in;
			ExcCode_out <= ExcCode_in;
			ACmpB_out <= ACmpB_in;
			ACmp0_out <= ACmp0_in;
		end
	end
	
	initial begin 
			BD_out = 0;
			IR_out = 0;
			PC_out = 0;
			Y_out  = 0;
			V2_out = 0;	
			HILO_out = 0;
			ExcCode_out = 5'd31;
			ACmpB_out = 0;
			ACmp0_out = 0;
	end
	
endmodule
