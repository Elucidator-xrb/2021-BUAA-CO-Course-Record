`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:35:23 11/20/2021 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset,
	 
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
	wire PC_en = !stall;
	wire D_reg_en = !stall, E_reg_en = 1, M_reg_en = 1, W_reg_en = 1;
	wire D_reg_rst = 0, E_reg_rst = stall, M_reg_rst = 0, W_reg_rst = 0;
	
	wire [4:0]  E2x_RFA3, M2x_RFA3, W2x_RFA3;
	wire [31:0] E2x_RFWD, M2x_RFWD, W2x_RFWD;
	wire 			E2x_RFWr, M2x_RFWr, W2x_RFWr;
	wire 			E2x_Ready, M2x_Ready, W2x_Ready;
	
	wire [1:0] D_ACmpB, E_ACmpB, M_ACmpB; // W_ACmpB;
	wire [1:0] D_ACmp0, E_ACmp0, M_ACmp0; // W_ACmp0;
	wire E_Busy;

	wire [31:0] NPC;
	wire [31:0] F_pc   , D_pc   , E_pc   , M_pc   , W_pc   ;
	wire [31:0] F_instr, D_instr, E_instr, M_instr, W_instr;
	IFU F_IFU (
    .Clk(clk), 
    .Rst(reset), 
	 .We(PC_en),
    .NPC(NPC), 
	 //output
    .PC_out(F_pc)
    );
	assign i_inst_addr = F_pc;
	assign F_instr = i_inst_rdata;
	 
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
	 
// ============== D�� =====================//		
	wire [31:0] W_WD;
	wire [4:0] W_A3;
	wire W_RFWr;

	wire [31:0] D_RD1, D_RD2, D_EXT;
	D_LEVEL D (
    .Clk(clk), 
    .Rst(reset), 
	 .Reg_Rst(D_reg_rst),
    .We(D_reg_en), 
    .IR_in(F_instr), 
    .PC_in(F_pc),
	 .WPC_in(W_pc),
    .A3_in(W_A3),
    .WD_in(W_WD),
    .RFWr_in(W_RFWr), 
	 //D�� ����E��/M��ת������
    .E_RFA3_in(E2x_RFA3), 
    .E_RFWD_in(E2x_RFWD), 
    .E_RFWr_in(E2x_RFWr), 
    .E_Forward_Ready_in(E2x_Ready), 
    .M_RFA3_in(M2x_RFA3), 
    .M_RFWD_in(M2x_RFWD), 
    .M_RFWr_in(M2x_RFWr), 
    .M_Forward_Ready_in(M2x_Ready), 
	 
	 //output
    // ��D��Ҫ�������ź�
	 .IR_out(D_instr), 
    .PC_out(D_pc), 
    .RD1_out(D_RD1), 
    .RD2_out(D_RD2), 
    .EXT_out(D_EXT), 
    .NPC_out(NPC),
	 .ACmpB_out(D_ACmpB),
	 .ACmp0_out(D_ACmp0)
    );

// ============== E�� =====================//		
	wire [31:0] E_Y, E_V2, E_HILO;
	E_LEVEL E (
    .Clk(clk), 
    .Rst(reset), 
	 .Reg_Rst(E_reg_rst),
    .We(E_reg_en), 
	 // ��D��������ź�
    .IR_in(D_instr), 
    .PC_in(D_pc), 
    .RD1_in(D_RD1), 
    .RD2_in(D_RD2), 
    .EXT_in(D_EXT), 
	 .ACmpB_in(D_ACmpB),
	 .ACmp0_in(D_ACmp0),
	 //E�� ����M��/W��ת������
    .M_RFA3_in(M2x_RFA3), 
    .M_RFWD_in(M2x_RFWD), 
    .M_RFWr_in(M2x_RFWr), 
    .M_Forward_Ready_in(M2x_Ready), 
    .W_RFA3_in(W2x_RFA3), 
    .W_RFWD_in(W2x_RFWD), 
    .W_RFWr_in(W2x_RFWr), 
    .W_Forward_Ready_in(W2x_Ready),
    
	 //output
	 // ��E��Ҫ�������ź�
	 .IR_out(E_instr), 
    .PC_out(E_pc), 
    .Y_out(E_Y), 
    .V2_out(E_V2), 
	 .HILO_out(E_HILO),
	 .ACmpB_out(E_ACmpB),
	 .ACmp0_out(E_ACmp0),
	 .Busy_out(E_Busy),
	 //E�� ���ת������
    .E_RFA3_out(E2x_RFA3), 
    .E_RFWD_out(E2x_RFWD), 
    .E_RFWr_out(E2x_RFWr), 
    .E_Forward_Ready_out(E2x_Ready)
    );
	
// ============== M�� =====================//	
	wire [31:0] M_Y, M_RD, M_HILO;
	M_LEVEL M (
    .Clk(clk), 
    .Rst(reset), 
	 .Reg_Rst(M_reg_rst),
    .We(M_reg_en), 
	 // ��E��������ź�
    .IR_in(E_instr), 
    .PC_in(E_pc), 
    .Y_in(E_Y), 
    .V2_in(E_V2),
	 .HILO_in(E_HILO),
	 .ACmpB_in(E_ACmpB),
	 .ACmp0_in(E_ACmp0),	 
	 //M�� ����W��ת������
	 .W_RFA3_in(W2x_RFA3), 
    .W_RFWD_in(W2x_RFWD), 
    .W_RFWr_in(W2x_RFWr), 
    .W_Forward_Ready_in(W2x_Ready), 
	 
	 //output
	 // ��M��Ҫ�������ź�
	 .IR_out(M_instr), 
    .PC_out(M_pc), 
    .Y_out(M_Y), 
    .RD_out(M_RD), 
	 .HILO_out(M_HILO),
	 .ACmpB_out(M_ACmpB),
	 .ACmp0_out(M_ACmp0),
	 //M�� ���ת������
    .M_RFWD_out(M2x_RFWD), 
    .M_RFA3_out(M2x_RFA3), 
    .M_RFWr_out(M2x_RFWr), 
    .M_Forward_Ready_out(M2x_Ready),
	 
	 //�洢������-�źŴ���
	 .m_data_addr(m_data_addr),  //�ͳ�
    .m_data_wdata(m_data_wdata),
    .m_data_byteen(m_data_byteen),
    .m_inst_addr(m_inst_addr),
	 
	 .m_data_rdata(m_data_rdata) //�ͻ�
    );

// ============== W�� =====================//	
	//wire [31:0] W_WD;
	//wire [4:0] W_A3;
	//wire W_RFWr;    ����warning����������ǰ��
	W_LEVEL W (
    .Clk(clk), 
    .Rst(reset), 
	 .Reg_Rst(W_reg_rst),
    .We(W_reg_en), 
	 // ��M��������ź�
    .IR_in(M_instr), 
    .PC_in(M_pc), 
    .DR_in(M_RD), 
    .Y_in(M_Y), 
	 .HILO_in(M_HILO),
	 .ACmpB_in(M_ACmpB),
	 .ACmp0_in(M_ACmp0),
    
	 //output
	 // ��W���������ź�
	 .IR_out(W_instr),
	 .PC_out(W_pc),
	 .A3_out(W_A3), 
	 .WD_out(W_WD), 
    .RFWr_out(W_RFWr), 
			//.ACmpB_out(W_ACmpB),
			//.ACmp0_out(W_ACmp0),
    //W�� ���ת������
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
