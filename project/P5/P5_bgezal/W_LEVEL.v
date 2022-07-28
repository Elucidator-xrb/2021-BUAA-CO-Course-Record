`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:54:52 11/22/2021 
// Design Name: 
// Module Name:    W_LEVEL 
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

module W_LEVEL(
    input Clk,
    input Rst,
	 input Reg_Rst,
    input We,
    input [31:0] IR_in,
    input [31:0] PC_in,
    input [31:0] DR_in,
    input [31:0] Y_in,
	 
    output [4:0] A3_out,
	 output [31:0] WD_out,
	 output RFWr_out,	 
	 output [31:0] IR_out,
	 output [31:0] PC_out,
	 
	 output [4:0] W_RFA3_out,
	 output [31:0] W_RFWD_out,
	 output W_RFWr_out,
	 output W_Forward_Ready_out
    );

	wire [31:0] DR_out, Y_out;
	W_REG W_REG (
    .Clk(Clk), 
    .Rst(Rst | Reg_Rst), 
    .We(We), 
    .IR_in(IR_in), 
    .PC_in(PC_in), 
    .DR_in(DR_in), 
    .Y_in(Y_in), 
	 //output
    .IR_out(IR_out), 
    .PC_out(PC_out), 
    .DR_out(DR_out), 
    .Y_out(Y_out)
    );

	wire [1:0] GRFA3Sel,GRFWDSel; //解析回写控制信号
	CU W_CU (
    .op(IR_out[31:26]), 
    .funct(IR_out[5:0]), 
    .rt_op(IR_out[20:16]), 
	 //output
    .RFWr(W_RFWr_out), 
    .GRFA3Sel(GRFA3Sel), 
    .GRFWDSel(GRFWDSel),
	 //指令检测
	 .cal_r(cal_r), 
    .cal_i(cal_i), 
	 .load(load),
	 .j_link(j_link)
    );
	 
	assign W_RFA3_out = (GRFA3Sel == `GRFA3_rt) ? IR_out[20:16] :
							  (GRFA3Sel == `GRFA3_rd) ? IR_out[15:11] :
						     (GRFA3Sel == `GRFA3_31) ? 5'd31 : 
							   IR_out[20:16];
	assign W_RFWD_out = (GRFWDSel == `GRFWD_alu) ? Y_out :
							  (GRFWDSel == `GRFWD_dm ) ? DR_out:
							  (GRFWDSel == `GRFWD_pc8) ? PC_out + 8 : 
								Y_out;
	assign W_Forward_Ready_out = cal_r | cal_i | load | j_link ;
	
	assign A3_out = W_RFA3_out;
	assign WD_out = W_RFWD_out;
	assign RFWr_out = W_RFWr_out;
	
endmodule
