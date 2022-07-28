`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:46:03 11/14/2021 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
    input Clk,
    input Rst,
    input [1:0] NPCOp,
    input [1:0] EXTOp,
    input [2:0] ALUOp,
	 input BSel,
    input [1:0] SSel,
    input [1:0] LSel,
    input [1:0] M1Sel,
    input [1:0] M2Sel,
    input M3Sel,
    input RFWr,
    input DMWr,
	 output [5:0] op,
	 output [5:0] funct
    );
	wire [31:0] IM_D; 
	wire [31:0] GRF_RD1, GRF_RD2;
	wire Zero;
	wire ACmp0;
	wire [31:0] PC_sgn, PC4;
	wire [31:0] EXT_O;
	wire [31:0] ALU_Y;
	wire [31:0] DM_RD;
	 
	wire [4:0] 	M1_out;
	wire [31:0] M2_out;
	wire [31:0] M3_out;
	assign M1_out = (M1Sel == 2'b00) ? IM_D[20:16] :
						 (M1Sel == 2'b01) ? IM_D[15:11] :
						 (M1Sel == 2'b10) ? 5'b11111	  : 0 ;
	assign M2_out = (M2Sel == 2'b00) ? PC4		:
						 (M2Sel == 2'b01) ? DM_RD	:
						 (M2Sel == 2'b10) ? ALU_Y	:
						 (M2Sel == 2'b11) ? EXT_O	: 0 ;
	assign M3_out = (M3Sel == 1'b0) ? GRF_RD2 : EXT_O ;
	
	assign op = IM_D[31:26];
	assign funct = IM_D[5:0];
	
	//所以最初设计端口时，输出口名称最好不重名，那样不用改也不容易混;但为了醒目，还是加上模块前缀吧
	IFU ifu (
    .Clk(Clk),			//Input
    .Rst(Rst), 
    .IMM(IM_D[25:0]), 
    .RA(GRF_RD1), 
    .NPCOp(NPCOp), 
	 .BSel(BSel),
	 .ACmp0(ACmp0),
    .Zero(Zero), 
    .PC4(PC4), 		//Output
    .IM_D(IM_D), 
    .PC_sgn(PC_sgn)
    );

	GRF grf (
    .PC(PC_sgn), 		//Input
    .Clk(Clk), 
    .Rst(Rst), 
    .A1(IM_D[25:21]), 
    .A2(IM_D[20:16]), 
    .A3(M1_out), 
    .WD(M2_out), 
    .RFWr(RFWr), 
    .RD1(GRF_RD1), 	//Output
    .RD2(GRF_RD2)
    );

	EXT ext (
    .I(IM_D[15:0]), 	//Input
    .EXTOp(EXTOp), 
    .O(EXT_O)			//Output
    );

	ALU alu (
    .A(GRF_RD1), 		//Input
    .B(M3_out), 
	 .Shamt(IM_D[10:6]),
    .ALUOp(ALUOp), 
    .Y(ALU_Y), 		//Output
    .Zero(Zero),
	 .ACmp0(ACmp0)
    );

	DM dm (
    .PC(PC_sgn), 		//Input
    .Clk(Clk), 
    .Rst(Rst), 
    .A(ALU_Y), 
    .WD(GRF_RD2), 
    .DMWr(DMWr), 
    .SSel(SSel), 
    .LSel(LSel), 
    .RD(DM_RD)			//Output
    );

endmodule
