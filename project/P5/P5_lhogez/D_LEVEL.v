`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:07:52 11/21/2021 
// Design Name: 
// Module Name:    D_LEVEL 
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
module D_LEVEL(
    input Clk,
    input Rst,
	 input Reg_Rst,
    input We, //reg写使能
	 input [31:0] IR_in,
	 input [31:0] PC_in,
	 input [31:0] WPC_in,
    input [31:0] WD_in,
    input [4:0] A3_in,
	 input RFWr_in,
	 
    input [4:0] E_RFA3_in,
	 input [31:0] E_RFWD_in,
	 input E_RFWr_in,
	 input E_Forward_Ready_in,
	 input [4:0] M_RFA3_in,
	 input [31:0] M_RFWD_in,
	 input M_RFWr_in,
	 input M_Forward_Ready_in,
	 
    output [31:0] IR_out,
    output [31:0] PC_out,
    output [31:0] RD1_out,
    output [31:0] RD2_out,
    output [31:0] EXT_out,
	 output [31:0] NPC_out
    );
	 
	 D_REG D_REG (
    .Clk(Clk), 
    .Rst(Rst | Reg_Rst), 
    .We(We), 
    .IR_in(IR_in), 
    .PC_in(PC_in), 
	 //output
    .IR_out(IR_out), 
    .PC_out(PC_out)
    );
	 
	 wire [1:0] ACmpB,ACmp0;
	 wire [1:0] NPCOp;
	 wire EXTOp;
	 CU D_CU (
    .op(IR_out[31:26]), 
    .funct(IR_out[5:0]), 
    .rt_op(IR_out[20:16]), 
    .ACmpB(ACmpB), 
    .ACmp0(ACmp0), 
	 //output
    .NPCOp(NPCOp), 
    .EXTOp(EXTOp)
    );
	
	 wire [31:0] RD1,RD2;
    D_GRF GRF (
    .WPC(WPC_in), 
    .Clk(Clk), 
    .Rst(Rst),  
    .A1(IR_out[25:21]), 
    .A2(IR_out[20:16]), 
    .A3(A3_in),  //W级解码后传入
    .WD(WD_in),  //W级解码后传入
	 .RFWr(RFWr_in), //W级解码后传入
	 //output
    .RD1(RD1), 
    .RD2(RD2)
    );
	 
	assign RD1_out = (IR_out[25:21] == 0) ? 0 :
						  (IR_out[25:21] == E_RFA3_in && E_RFWr_in && E_Forward_Ready_in) ? E_RFWD_in :
						  (IR_out[25:21] == M_RFA3_in && M_RFWr_in && M_Forward_Ready_in) ? M_RFWD_in :
							 RD1 ;
	assign RD2_out = (IR_out[20:16] == 0) ? 0 :
						  (IR_out[20:16] == E_RFA3_in && E_RFWr_in && E_Forward_Ready_in) ? E_RFWD_in :
						  (IR_out[20:16] == M_RFA3_in && M_RFWr_in && M_Forward_Ready_in) ? M_RFWD_in :
							 RD2 ;
	 
	 D_CMP CMP (
    .A(RD1_out), 
    .B(RD2_out), 
	 //output
    .ACmpB(ACmpB), 
    .ACmp0(ACmp0)
    );

    D_EXT EXT (
    .I(IR_out[15:0]), 
    .EXTOp(EXTOp), 
    .O(EXT_out)
    );
	
    D_NPC NPC (
    .PC(PC_out), 
	 .PC_F(PC_in),
    .IMM(IR_out[25:0]), 
    .RA(RD1_out), 
    .NPCOp(NPCOp), 
    .NPC(NPC_out)
    );
	 
endmodule
