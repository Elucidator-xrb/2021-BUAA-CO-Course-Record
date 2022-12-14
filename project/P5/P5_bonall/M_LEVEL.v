`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:39:37 11/22/2021 
// Design Name: 
// Module Name:    M_LEVEL 
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

module M_LEVEL(
    input Clk,
    input Rst,
	 input Reg_Rst,
    input We,
    input [31:0] IR_in,
    input [31:0] PC_in,
    input [31:0] Y_in,
    input [31:0] V2_in,
	 
	 input [4:0] W_RFA3_in,
	 input [31:0] W_RFWD_in,
	 input W_RFWr_in,
	 input W_Forward_Ready_in,
	 
    output [31:0] IR_out,
    output [31:0] PC_out,
    output [31:0] Y_out,
    output [31:0] RD_out,
	 
	 output [4:0] M_RFA3_out,
	 output [31:0] M_RFWD_out,
	 output M_RFWr_out,
	 output M_Forward_Ready_out
    );

	wire [31:0] V2_out;
	M_REG M_REG (
    .Clk(Clk), 
    .Rst(Rst | Reg_Rst), 
    .We(We), 
    .IR_in(IR_in), 
    .PC_in(PC_in), 
    .Y_in(Y_in), 
    .V2_in(V2_in), 
	 //output
    .IR_out(IR_out), 
    .PC_out(PC_out), 
    .Y_out(Y_out), 
    .V2_out(V2_out)
    );

	wire [2:0] DMOp;
	wire DMWr;
	wire [1:0] GRFA3Sel,GRFWDSel; //解析回写控制信号
	wire cal_r, cal_i, j_link; //解析当前指令类型，以判断是否以产生数据可以转发
	CU M_CU (
    .op(IR_out[31:26]), 
    .funct(IR_out[5:0]), 
    .rt_op(IR_out[20:16]),  
	 //output
    .DMOp(DMOp), 
    .DMWr(DMWr),
	 //指令检测
	 .RFWr(M_RFWr_out), 
    .GRFA3Sel(GRFA3Sel), 
    .GRFWDSel(GRFWDSel),
	 
	 .cal_r(cal_r),
	 .cal_i(cal_i),
	 .j_link(j_link)
    );
	 
	assign M_RFA3_out = (GRFA3Sel == `GRFA3_rt) ? IR_out[20:16] :
							  (GRFA3Sel == `GRFA3_rd) ? IR_out[15:11] :
						     (GRFA3Sel == `GRFA3_31) ? 5'd31 : 
							   IR_out[20:16];
	assign M_RFWD_out = (GRFWDSel == `GRFWD_alu) ? Y_out :
							  (GRFWDSel == `GRFWD_pc8) ? PC_out + 8 : 
								0 ;
	assign M_Forward_Ready_out = cal_r | cal_i | j_link ;
	
	wire [31:0] FWD_RT;
	assign FWD_RT = (IR_out[20:16] == 0) ? 0 :
						 (IR_out[20:16] == W_RFA3_in && W_RFWr_in && W_Forward_Ready_in) ? W_RFWD_in :
						  V2_out ;

	M_DM DM (
    .WPC(PC_out), 
    .Clk(Clk), 
    .Rst(Rst), 
    .DMWr(DMWr), 
    .A(Y_out), 
    .WD(FWD_RT), 
    .DMOp(DMOp), 
	 //output
    .RD(RD_out)
    );


endmodule
