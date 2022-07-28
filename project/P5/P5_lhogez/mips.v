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
    input reset
    );
	wire PC_en = !stall;
	wire D_reg_en = !stall, E_reg_en = 1, M_reg_en = 1, W_reg_en = 1;
	wire D_reg_rst = 0, E_reg_rst = stall, M_reg_rst = 0, W_reg_rst = 0;
	
	wire stall;
	
	wire [4:0]  E2x_RFA3, M2x_RFA3, W2x_RFA3;
	wire [31:0] E2x_RFWD, M2x_RFWD, W2x_RFWD;
	wire 			E2x_RFWr, M2x_RFWr, W2x_RFWr;
	wire 			E2x_Ready, M2x_Ready, W2x_Ready;
	
	integer handle;
	initial begin
		handle = $fopen("../msg_out_cpu.txt","w");
		$fclose(handle);
	end
	

	wire [31:0] NPC;
	wire [31:0] F_instr, D_instr, E_instr, M_instr, W_instr;
	wire [31:0] F_pc, D_pc, E_pc, M_pc, W_pc;
	IFU F_IFU (
    .Clk(clk), 
    .Rst(reset), 
	 .We(PC_en),
    .NPC(NPC), 
	 //output
    .PC_out(F_pc), 
    .IM_D(F_instr)
    );
	 
	 SU StallUnit (
    .D_instr(D_instr), 
    .E_instr(E_instr), 
    .M_instr(M_instr),
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
    .IR_out(D_instr), 
    .PC_out(D_pc), 
    .RD1_out(D_RD1), 
    .RD2_out(D_RD2), 
    .EXT_out(D_EXT), 
    .NPC_out(NPC)
    );

// ============== E�� =====================//		
	wire [31:0] E_Y, E_V2;
	E_LEVEL E (
    .Clk(clk), 
    .Rst(reset), 
	 .Reg_Rst(E_reg_rst),
    .We(E_reg_en), 
    .IR_in(D_instr), 
    .PC_in(D_pc), 
    .RD1_in(D_RD1), 
    .RD2_in(D_RD2), 
    .EXT_in(D_EXT), 
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
	 .IR_out(E_instr), 
    .PC_out(E_pc), 
    .Y_out(E_Y), 
    .V2_out(E_V2), 
	 //E�� ���ת������
    .E_RFA3_out(E2x_RFA3), 
    .E_RFWD_out(E2x_RFWD), 
    .E_RFWr_out(E2x_RFWr), 
    .E_Forward_Ready_out(E2x_Ready)
    );
	
// ============== M�� =====================//	
	wire [31:0] M_Y, M_RD;
	M_LEVEL M (
    .Clk(clk), 
    .Rst(reset), 
	 .Reg_Rst(M_reg_rst),
    .We(M_reg_en), 
    .IR_in(E_instr), 
    .PC_in(E_pc), 
    .Y_in(E_Y), 
    .V2_in(E_V2),	 
	 //M�� ����W��ת������
	 .W_RFA3_in(W2x_RFA3), 
    .W_RFWD_in(W2x_RFWD), 
    .W_RFWr_in(W2x_RFWr), 
    .W_Forward_Ready_in(W2x_Ready), 
	 //output
	 .IR_out(M_instr), 
    .PC_out(M_pc), 
    .Y_out(M_Y), 
    .RD_out(M_RD), 
	 //M�� ���ת������
    .M_RFWD_out(M2x_RFWD), 
    .M_RFA3_out(M2x_RFA3), 
    .M_RFWr_out(M2x_RFWr), 
    .M_Forward_Ready_out(M2x_Ready)
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
    .IR_in(M_instr), 
    .PC_in(M_pc), 
    .DR_in(M_RD), 
    .Y_in(M_Y), 
    //output
	 .IR_out(W_instr),
	 .PC_out(W_pc),
	 .A3_out(W_A3), 
	 .WD_out(W_WD), 
    .RFWr_out(W_RFWr), 
	      //.IR_out(IR_out), 
         //.PC_out(PC_out), 
    //W�� ���ת������
	 .W_RFWD_out(W2x_RFWD), 
    .W_RFA3_out(W2x_RFA3), 
    .W_RFWr_out(W2x_RFWr), 
    .W_Forward_Ready_out(W2x_Ready)
    );
 
endmodule
