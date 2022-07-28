`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:15:59 11/22/2021 
// Design Name: 
// Module Name:    E_LEVEL 
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
`include "const.v"

module E_LEVEL(
    input Clk,
    input Rst,
	 input Reg_Rst,
    input We,
    input [31:0] IR_in,
    input [31:0] PC_in,
    input [31:0] RD1_in,
    input [31:0] RD2_in,
    input [31:0] EXT_in,
	 
    input [4:0] M_RFA3_in,
	 input [31:0] M_RFWD_in,
	 input M_RFWr_in,
	 input M_Forward_Ready_in,
	 input [4:0] W_RFA3_in,
	 input [31:0] W_RFWD_in,
	 input W_RFWr_in,
	 input W_Forward_Ready_in,
	 
    output [31:0] IR_out,
    output [31:0] PC_out,
    output [31:0] Y_out,
    output [31:0] V2_out,
	 
	 output [4:0] E_RFA3_out,
	 output [31:0] E_RFWD_out,
	 output E_RFWr_out,
	 output E_Forward_Ready_out
    );
	
	wire [31:0] V1_out,V2_out0;
	wire [31:0] EXT_out;
	E_REG E_REG (
    .Clk(Clk), 
    .Rst(Rst | Reg_Rst), 
    .We(We), 
    .IR_in(IR_in), 
    .PC_in(PC_in), 
    .EXT_in(EXT_in), 
    .V1_in(RD1_in), 
    .V2_in(RD2_in),
	 //output
    .IR_out(IR_out), 
    .PC_out(PC_out), 
    .EXT_out(EXT_out), 
    .V1_out(V1_out), 
    .V2_out(V2_out0) //这里V2_out还不能直接作为E级输出，需要用转发后的数据
    );

	wire [3:0] ALUOp;
	wire [1:0] ALUBSel;
	wire [1:0] GRFA3Sel,GRFWDSel;//解析回写控制信号
	wire j_link; //解析当前指令类型，以判断是否以产生数据可以转发
	CU E_CU (
    .op(IR_out[31:26]), 
    .funct(IR_out[5:0]), 
    .rt_op(IR_out[20:16]),  
	 //output
    .ALUOp(ALUOp),  
    .ALUBSel(ALUBSel),
	 
	 .RFWr(E_RFWr_out), 
    .GRFA3Sel(GRFA3Sel), 
    .GRFWDSel(GRFWDSel),
	 //指令检测
	 .j_link(j_link)
    );
	
	assign E_RFA3_out = (GRFA3Sel == `GRFA3_rt) ? IR_out[20:16] :
							  (GRFA3Sel == `GRFA3_rd) ? IR_out[15:11] :
						     (GRFA3Sel == `GRFA3_31) ? 5'd31 : 
							   IR_out[20:16];
	assign E_RFWD_out = (GRFWDSel == `GRFWD_pc8) ? PC_out + 8 : 
								0 ;
	assign E_Forward_Ready_out = j_link ;
	 
	
 	wire [31:0] ALU_A, ALU_B;
	wire [31:0] FWD_RS, FWD_RT;
	assign FWD_RS = (IR_out[25:21] == 0) ? 0 :
						 (IR_out[25:21] == M_RFA3_in && M_RFWr_in && M_Forward_Ready_in) ? M_RFWD_in :
						 (IR_out[25:21] == W_RFA3_in && W_RFWr_in && W_Forward_Ready_in) ? W_RFWD_in :
							V1_out ;
	assign FWD_RT = (IR_out[20:16] == 0) ? 0 :
						 (IR_out[20:16] == M_RFA3_in && M_RFWr_in && M_Forward_Ready_in) ? M_RFWD_in :
						 (IR_out[20:16] == W_RFA3_in && W_RFWr_in && W_Forward_Ready_in) ? W_RFWD_in :
							V2_out0 ;
	assign ALU_A = FWD_RS ;
	assign ALU_B = (ALUBSel == `ALUB_rd2) ? FWD_RT 		:
						(ALUBSel == `ALUB_imm) ? EXT_out	 	:
						(ALUBSel == `ALUB_shamt) ? IR_out[10:6] : 0 ;
						
	assign V2_out = FWD_RT; //转发处理后正确的数据才能传到下一级

	E_ALU ALU (
    .A(ALU_A), 
    .B(ALU_B), 
    .ALUOp(ALUOp), 
	 //output
    .Y(Y_out)
    );

endmodule
