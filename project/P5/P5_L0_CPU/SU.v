`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:32:31 11/22/2021 
// Design Name: 
// Module Name:    SU 
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

module SU(
    input [31:0] D_instr,
    input [31:0] E_instr,
    input [31:0] M_instr,
	 input [1:0] E_ACmpB,
	 input [1:0] M_ACmpB,
	 input [1:0] E_ACmp0,
	 input [1:0] M_ACmp0,
    output stall
    );
	 
	wire [1:0] Tuse_RS, Tuse_RT;
	wire [1:0] Tnew_E, Tnew_M;
	wire stall_rs_e, stall_rs_m, stall_rs;
	wire stall_rt_e, stall_rt_m, stall_rt;
	
	assign stall_rs_e = (Tuse_RS < Tnew_E) && D_instr[25:21] && (D_instr[25:21] == E_RFA3) && E_RFWr;
	assign stall_rs_m = (Tuse_RS < Tnew_M) && D_instr[25:21] && (D_instr[25:21] == M_RFA3) && M_RFWr;
	assign stall_rs = stall_rs_e | stall_rs_m ;

	assign stall_rt_e = (Tuse_RT < Tnew_E) && D_instr[20:16] && (D_instr[20:16] == E_RFA3) && E_RFWr;
	assign stall_rt_m = (Tuse_RT < Tnew_M) && D_instr[20:16] && (D_instr[20:16] == M_RFA3) && M_RFWr;
	assign stall_rt = stall_rt_e | stall_rt_m ;
	
	assign stall = stall_rs | stall_rt ;

// ============== D¼¶ =====================//		
	wire D_cal_r, D_cal_i, D_load, D_store, D_branch, D_j_reg;
	CU D_instr_judge (
    .op(D_instr[31:26]), 
    .funct(D_instr[5:0]), 
    .rt_op(D_instr[20:16]), 
	 //output
    .cal_r(D_cal_r), 
    .cal_i(D_cal_i), 
    .load(D_load), 
    .store(D_store), 
    .branch(D_branch), 
    .j_reg(D_j_reg)
    );

	assign Tuse_RS = (D_cal_r | D_cal_i | D_load | D_store) ? 2'd1:
						  (D_branch | D_j_reg) ? 2'd0 : 2'd3 ;
	assign Tuse_RT = (D_store) ? 2'd2 :
						  (D_cal_r) ? 2'd1 :
						  (D_branch)? 2'd0 : 2'd3 ;

// ============== E¼¶ =====================//		
	wire E_cal_r, E_cal_i, E_load;
	wire E_RFWr;
	wire [1:0] E_GRFA3Sel;
	wire [4:0] E_RFA3;
	CU E_instr_judge (
    .op(E_instr[31:26]), 
    .funct(E_instr[5:0]), 
    .rt_op(E_instr[20:16]), 
	 .ACmpB(E_ACmpB),
	 .ACmp0(E_ACmp0),
	 //output
    .cal_r(E_cal_r), 
    .cal_i(E_cal_i), 
    .load(E_load), 
	 
    .RFWr(E_RFWr), 
    .GRFA3Sel(E_GRFA3Sel)
    );
	
	assign E_RFA3 = (E_GRFA3Sel == `GRFA3_rt) ? E_instr[20:16] :
						 (E_GRFA3Sel == `GRFA3_rd) ? E_instr[15:11] :
						 (E_GRFA3Sel == `GRFA3_31) ? 5'd31 : 
						 (E_GRFA3Sel == `GRFA3_00) ? 5'd0  : 
						   E_instr[20:16];
	assign Tnew_E = (E_load) ? 2'd2 :
						 (E_cal_r | E_cal_i) ? 2'd1 :
							2'd0;

// ============== M¼¶ =====================//		
	wire M_load;
	wire M_RFWr;
	wire [1:0] M_GRFA3Sel;
	wire [4:0] M_RFA3;
	CU M_instr_judge (
    .op(M_instr[31:26]), 
    .funct(M_instr[5:0]), 
    .rt_op(M_instr[20:16]), 
	 .ACmpB(M_ACmpB),	 
	 .ACmp0(M_ACmp0),	 
	 //output
    .load(M_load),  
     
    .RFWr(M_RFWr), 
    .GRFA3Sel(M_GRFA3Sel)
    );
	
	assign M_RFA3 = (M_GRFA3Sel == `GRFA3_rt) ? M_instr[20:16] :
						 (M_GRFA3Sel == `GRFA3_rd) ? M_instr[15:11] :
						 (M_GRFA3Sel == `GRFA3_31) ? 5'd31 : 
						 (M_GRFA3Sel == `GRFA3_00) ? 5'd0  : 
						   M_instr[20:16];
	assign Tnew_M = M_load ? 2'd1 : 2'd0 ;

endmodule
