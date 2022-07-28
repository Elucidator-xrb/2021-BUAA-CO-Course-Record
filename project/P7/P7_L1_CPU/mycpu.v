`timescale 1ns / 1ps
`include "const.v"

module mycpu_top(
    input clk,
    input reset,
	 
	 input [5:0] HWInt,
	 
	 output [31:0] i_inst_addr,
	 input  [31:0] i_inst_rdata,
	 
	 output [31:0] m_data_addr,
	 output [3:0]  m_data_byteen,
	 output [31:0] m_data_wdata,
	 output [31:0] m_inst_addr,
	 input  [31:0] m_data_rdata,
	 
	 output w_grf_we,
	 output [4:0]  w_grf_addr,
	 output [31:0] w_grf_wdata,
	 output [31:0] w_inst_addr
    );
	
	wire stall;
	wire PC_en = !stall;   // may considered as F_reg_en
	wire D_reg_en = !stall, E_reg_en = 1, M_reg_en = 1, W_reg_en = 1;
	wire D_reg_rst = 0, E_reg_rst = stall, M_reg_rst = 0, W_reg_rst = 0;
	
	wire [4:0]  E2x_RFA3, M2x_RFA3, W2x_RFA3;
	wire [31:0] E2x_RFWD, M2x_RFWD, W2x_RFWD;
	wire 			E2x_RFWr, M2x_RFWr, W2x_RFWr;
	wire 			E2x_Ready, M2x_Ready, W2x_Ready;
	
	wire [1:0] D_ACmpB, E_ACmpB, M_ACmpB; // W_ACmpB;
	wire [1:0] D_ACmp0, E_ACmp0, M_ACmp0; // W_ACmp0;
	wire E_Busy;

	wire Req;
	wire [31:0] NPC, EPC;
	wire [31:0] F_pc   , D_pc   , E_pc   , M_pc   , W_pc   ;
	wire [31:0] F_instr, D_instr, E_instr, M_instr, W_instr;
	wire [4:0]  F_ExcCode, D_ExcCode, E_ExcCode, M_ExcCode ;
	wire D_bd, E_bd;
	
	IFU F_IFU (
    .Clk(clk), 
    .Rst(reset), 
	 .We(PC_en),
    .NPC(NPC), 
	 //output
	 .ExcAdEL(ExcAdEL),
    .PC_out(F_pc)
    );
	assign i_inst_addr = F_pc;
	assign F_instr = i_inst_rdata;
	assign F_ExcCode = ExcAdEL ? `Exc_AdEL : `Exc_Null;
	 
	 SU SU (
    .D_instr(D_instr), 
    .E_instr(E_instr), 
    .M_instr(M_instr),
	 
	 .E_ACmpB(E_ACmpB),
	 .M_ACmpB(M_ACmpB),
	 .E_ACmp0(E_ACmp0),
	 .M_ACmp0(M_ACmp0),
	 
	 .E_Busy(E_Busy),
	 //output
    .stall(stall)
    );
	 
// ============== D级 =====================//		
	wire [31:0] W_WD;
	wire [4:0] W_A3;
	wire W_RFWr;

	wire [31:0] D_RD1, D_RD2, D_EXT;
	D_LEVEL D (
    .Clk(clk), 
    .Rst(reset), 
	 .Reg_Rst(D_reg_rst),
    .We(D_reg_en), 
	 .Req(Req),
	 .EPC_in(EPC),
    .IR_in(F_instr), 
    .PC_in(F_pc),
	 .ExcCode_in(F_ExcCode),
	 .WPC_in(W_pc),
    .A3_in(W_A3),
    .WD_in(W_WD),
    .RFWr_in(W_RFWr), 
	 //D级 接收E级/M级转发数据
    .E_RFA3_in(E2x_RFA3), 
    .E_RFWD_in(E2x_RFWD), 
    .E_RFWr_in(E2x_RFWr), 
    .E_Forward_Ready_in(E2x_Ready), 
    .M_RFA3_in(M2x_RFA3), 
    .M_RFWD_in(M2x_RFWD), 
    .M_RFWr_in(M2x_RFWr), 
    .M_Forward_Ready_in(M2x_Ready), 
	 
	 //output
    // 从D级要流出的信号
	 .BD_out(D_bd),
	 .IR_out(D_instr), 
    .PC_out(D_pc), 
    .RD1_out(D_RD1), 
    .RD2_out(D_RD2), 
    .EXT_out(D_EXT), 
    .NPC_out(NPC),
	 .ExcCode_out(D_ExcCode),
	 .ACmpB_out(D_ACmpB),
	 .ACmp0_out(D_ACmp0)
    );

// ============== E级 =====================//		
	wire [31:0] E_Y, E_V2, E_HILO;
	E_LEVEL E (
    .Clk(clk), 
    .Rst(reset), 
	 .Reg_Rst(E_reg_rst),
    .We(E_reg_en), 
	 .Req(Req),
	 // 从D级流入的信号
	 .BD_in(D_bd),
    .IR_in(D_instr), 
    .PC_in(D_pc), 
    .RD1_in(D_RD1), 
    .RD2_in(D_RD2), 
    .EXT_in(D_EXT), 
	 .ExcCode_in(D_ExcCode),
	 .ACmpB_in(D_ACmpB),
	 .ACmp0_in(D_ACmp0),
	 //E级 接收M级/W级转发数据
    .M_RFA3_in(M2x_RFA3), 
    .M_RFWD_in(M2x_RFWD), 
    .M_RFWr_in(M2x_RFWr), 
    .M_Forward_Ready_in(M2x_Ready), 
    .W_RFA3_in(W2x_RFA3), 
    .W_RFWD_in(W2x_RFWD), 
    .W_RFWr_in(W2x_RFWr), 
    .W_Forward_Ready_in(W2x_Ready),
    
	 //output
	 // 从E级要流出的信号
	 .BD_out(E_bd),
	 .IR_out(E_instr), 
    .PC_out(E_pc), 
    .Y_out(E_Y), 
    .V2_out(E_V2), 
	 .HILO_out(E_HILO),
	 .ExcCode_out(E_ExcCode),
	 .ACmpB_out(E_ACmpB),
	 .ACmp0_out(E_ACmp0),
	 .Busy_out(E_Busy),
	 //E级 输出转发数据
    .E_RFA3_out(E2x_RFA3), 
    .E_RFWD_out(E2x_RFWD), 
    .E_RFWr_out(E2x_RFWr), 
    .E_Forward_Ready_out(E2x_Ready)
    );
	
// ============== M级 =====================//	
	wire [31:0] M_Y, M_RD, M_HILO;
	M_LEVEL M (
    .Clk(clk), 
    .Rst(reset), 
	 .Reg_Rst(M_reg_rst),
    .We(M_reg_en),	 
	 // 从E级流入的信号
	 .BD_in(E_bd),
    .IR_in(E_instr), 
    .PC_in(E_pc), 
    .Y_in(E_Y), 
    .V2_in(E_V2),
	 .HILO_in(E_HILO),
	 .ExcCode_in(E_ExcCode_in),
	 .ACmpB_in(E_ACmpB),
	 .ACmp0_in(E_ACmp0),	 
	 .HWInt(HWInt),
	 //M级 接收W级转发数据
	 .W_RFA3_in(W2x_RFA3), 
    .W_RFWD_in(W2x_RFWD), 
    .W_RFWr_in(W2x_RFWr), 
    .W_Forward_Ready_in(W2x_Ready),

	 //output
	 // Exception signal out
	 .Req(Req),
	 .EPCOut(EPC),
	 // 从M级要流出的信号
	 .IR_out(M_instr), 
    .PC_out(M_pc), 
    .Y_out(M_Y), 
    .RD_out(M_RD), 
	 .HILO_out(M_HILO),
	 .ACmpB_out(M_ACmpB),
	 .ACmp0_out(M_ACmp0),
	 //M级 输出转发数据
    .M_RFWD_out(M2x_RFWD), 
    .M_RFA3_out(M2x_RFA3), 
    .M_RFWr_out(M2x_RFWr), 
    .M_Forward_Ready_out(M2x_Ready),
	 
	 //存储器外置-信号传输
	 .m_data_addr(m_data_addr),  //送出
    .m_data_wdata(m_data_wdata),
    .m_data_byteen(m_data_byteen),
    .m_inst_addr(m_inst_addr),
	 
	 .m_data_rdata(m_data_rdata) //送回
    );

// ============== W级 =====================//	
	//wire [31:0] W_WD;
	//wire [4:0] W_A3;
	//wire W_RFWr;    清理warning，定义在了前面
	W_LEVEL W (
    .Clk(clk), 
    .Rst(reset), 
	 .Reg_Rst(W_reg_rst),
    .We(W_reg_en), 
	 // 从M级流入的信号
    .IR_in(M_instr), 
    .PC_in(M_pc), 
    .DR_in(M_RD), 
    .Y_in(M_Y), 
	 .HILO_in(M_HILO),
	 .ACmpB_in(M_ACmpB),
	 .ACmp0_in(M_ACmp0),
    
	 //output
	 // 从W级流出的信号
	 .IR_out(W_instr),
	 .PC_out(W_pc),
	 .A3_out(W_A3), 
	 .WD_out(W_WD), 
    .RFWr_out(W_RFWr), 
			//.ACmpB_out(W_ACmpB),
			//.ACmp0_out(W_ACmp0),
    //W级 输出转发数据
	 .W_RFWD_out(W2x_RFWD), 
    .W_RFA3_out(W2x_RFA3), 
    .W_RFWr_out(W2x_RFWr), 
    .W_Forward_Ready_out(W2x_Ready)
    );
	 
	assign w_grf_we = W_RFWr;
	assign w_grf_addr = W_A3;
	assign w_grf_wdata = W_WD;
	assign w_inst_addr = W_pc;
 
endmodule
