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
	 input BD_in,
    input [31:0] IR_in,
    input [31:0] PC_in,
    input [31:0] Y_in,
    input [31:0] V2_in,
	 input [31:0] HILO_in,
	 input [4:0] ExcCode_in,
	 input [1:0] ACmpB_in,
	 input [1:0] ACmp0_in,
	 
	 input [4:0] W_RFA3_in,
	 input [31:0] W_RFWD_in,
	 input W_RFWr_in,
	 input W_Forward_Ready_in,
	 
    output [31:0] IR_out,
    output [31:0] PC_out,
    output [31:0] Y_out,
    output [31:0] RD_out,
	 output [31:0] HILO_out,
	 output [1:0] ACmpB_out,
	 output [1:0] ACmp0_out,
	 
	 input [5:0] HWInt,
	 output Req,
	 output [31:0] EPCOut,
	 
	 output [4:0] M_RFA3_out,
	 output [31:0] M_RFWD_out,
	 output M_RFWr_out,
	 output M_Forward_Ready_out,
	 
	 //存储器外置
	 output [31:0] m_data_addr,
	 output [3:0]  m_data_byteen,
	 output [31:0] m_data_wdata,
	 output [31:0] m_inst_addr,
	 input  [31:0] m_data_rdata
    );

	wire [31:0] V2_out;
	wire [4:0] ExcCode_former, ExcCode_cur;
	wire BD_out;
	M_REG M_REG (
    .Clk(Clk), 
    .Rst(Rst | Reg_Rst), 
    .We(We), 
	 .Req(Req),
	 
	 .BD_in(BD_in),
    .IR_in(IR_in), 
    .PC_in(PC_in), 
    .Y_in(Y_in), 
    .V2_in(V2_in), 
	 .HILO_in(HILO_in),
	 .ExcCode_in(ExcCode_in),
	 .ACmpB_in(ACmpB_in),
	 .ACmp0_in(ACmp0_in),
	 
	 //output
	 .BD_out(BD_out),
    .IR_out(IR_out), 
    .PC_out(PC_out), 
    .Y_out(Y_out), 
    .V2_out(V2_out),
	 .HILO_out(HILO_out),
	 .ExcCode_out(ExcCode_former),
	 .ACmpB_out(ACmpB_out),
	 .ACmp0_out(ACmp0_out)
    );

	wire [2:0] DMOp;
	wire DMWr, CP0Wr;
	wire [1:0] MRDSel;
	wire [1:0] GRFA3Sel,GRFWDSel; //解析回写控制信号
	wire cal_r, cal_i, j_link; 	//解析当前指令类型，以判断是否以产生数据可以转发
	wire eret;
	CU M_CU (
	 .instr(IR_out),
    .op(IR_out[31:26]), 
    .funct(IR_out[5:0]),
	 .rs_op(IR_out[25:21]),
    .rt_op(IR_out[20:16]),
	 .ACmpB(ACmpB_out),
	 .ACmp0(ACmp0_out),
	 //output
    .DMOp(DMOp), 
    .DMWr(DMWr),
	 .CP0Wr(CP0Wr),
	 .MRDSel(MRDSel),
	 //指令检测
	 .RFWr(M_RFWr_out), 
    .GRFA3Sel(GRFA3Sel), 
    .GRFWDSel(GRFWDSel),
	 
	 .cal_r(cal_r),
	 .cal_i(cal_i),
	 .j_link(j_link),
	 .mf(mf),
	 .eret(eret)
    );
	 
	assign M_RFA3_out = (GRFA3Sel == `GRFA3_rt) ? IR_out[20:16] :
							  (GRFA3Sel == `GRFA3_rd) ? IR_out[15:11] :
						     (GRFA3Sel == `GRFA3_31) ? 5'd31 : 
						     (GRFA3Sel == `GRFA3_00) ? 5'd0  : 
							   IR_out[20:16];
	assign M_RFWD_out = (GRFWDSel == `GRFWD_alu) ? Y_out :
							  (GRFWDSel == `GRFWD_pc8) ? PC_out + 8 : 
								0 ;
	assign M_Forward_Ready_out = cal_r | cal_i | j_link | mf ;
	
	wire [31:0] FWD_RT;
	assign FWD_RT = (IR_out[20:16] == 0) ? 0 :
						 (IR_out[20:16] == W_RFA3_in && W_RFWr_in && W_Forward_Ready_in) ? W_RFWD_in :
						  V2_out ;

//	M_DM DM (
//    .WPC(PC_out), 
//    .Clk(Clk), 
//    .Rst(Rst), 
//    .DMWr(DMWr), 
//    .A(Y_out), 
//    .WD(FWD_RT), 
//    .DMOp(DMOp), 
//	   //output
//    .RD(RD_out)
//    );

	M_BE BE (
	 .A(Y_out),
	 .Write(FWD_RT),
	 .DMOp(DMOp),
	 .DMWr(DMWr),
	 //output
	 .ExcAdEL(ExcAdEL),
	 .ExcAdES(ExcAdES),
	 .ByteEn(m_data_byteen),
	 .DataWd(m_data_wdata)
	 );
	assign m_data_addr = Y_out;
	assign m_inst_addr = PC_out;
	
	assign ExcCode_cur = (ExcCode_former != `Exc_Null) ? ExcCode_former :
								(ExcAdEL == 1) ? `Exc_AdEL :
								(ExcAdES == 1) ? `Exc_AdES :
								 `Exc_Null ;
	
	wire [31:0] DM_Dout;
	M_DEXT DEXT (
    .Addr(Y_out[1:0]), 
    .Data(m_data_rdata), 
    .DMOp(DMOp), 
    .DOut(DM_Dout)
    );

	wire [31:0] CP0_Dout;
	CP0 CP0 (
    .Clk(Clk), 
    .Rst(Rst), 
    .We(CP0Wr), 
    .A1(IR_out[15:11]), 
    .A2(IR_out[15:11]), 
	 .BDIn(BD_out),
    .DIn(FWD_RT), 
    .PCIn(PC_out), 
    .ExcCodeIn(ExcCode_cur), 
    .HWInt(HWInt), 
    .EXLSet(EXLSet),   // unused
    .EXLClr(eret), 
	 
	 //output
    .Req(Req), 
    .EPCOut(EPCOut), 
    .DOut(CP0_Dout)
    );
	 
	assign RD_out = (MRDSel == `MRD_cp0) ? CP0_Dout : DM_Dout; 


endmodule
