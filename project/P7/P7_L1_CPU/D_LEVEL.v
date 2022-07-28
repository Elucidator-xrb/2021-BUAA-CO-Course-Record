`timescale 1ns / 1ps
`include "const.v"

module D_LEVEL(
    input Clk,
    input Rst,
	 input Reg_Rst,
    input We, //reg写使能
	 input Req,
	 input [31:0] EPC_in,
	 input [31:0] IR_in,
	 input [31:0] PC_in,
	 input [4:0] ExcCode_in,
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
	 
	 output BD_out,
    output [31:0] IR_out,
    output [31:0] PC_out,
    output [31:0] RD1_out,
    output [31:0] RD2_out,
    output [31:0] EXT_out,
	 output [4:0] ExcCode_out,
	 output [1:0]  ACmpB_out,
	 output [1:0]  ACmp0_out,
	 output [31:0] NPC_out
    );
	
	wire [4:0] ExcCode_former;
	D_REG D_REG (
    .Clk(Clk), 
    .Rst(Rst | Reg_Rst), 
    .We(We), 
	 .Req(Req),
	 
	 .BD_in(bd_instr), // next instr will carry bd signal
    .IR_in(IR_in), 
    .PC_in(PC_in),
	 .ExcCode_in(ExcCode_in),
	 
	 //output
	 .BD_out(BD_out),
    .IR_out(IR_out), 
    .PC_out(PC_out),
	 .ExcCode_out(ExcCode_former)
    );
	 
	wire [1:0] NPCOp;
	wire eret, bd_instr;
	wire EXTOp;
	CU D_CU (
	 .instr(IR_out),
    .op(IR_out[31:26]), 
    .funct(IR_out[5:0]), 
	 .rs_op(IR_out[25:21]),
    .rt_op(IR_out[20:16]), 
    .ACmpB(ACmpB_out), 
    .ACmp0(ACmp0_out), 
	 //output
    .NPCOp(NPCOp), 
    .EXTOp(EXTOp),
	 .ExcRI(ExcRI),
	 
	 .eret(eret),
	 .bd_instr(bd_instr)
    );
	
	assign ExcCode_out = (ExcCode_former == `Exc_Null && ExcRI) ? `Exc_RI : ExcCode_former;
	
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
    .ACmpB(ACmpB_out), 
    .ACmp0(ACmp0_out)
    );

   D_EXT EXT (
    .I(IR_out[15:0]), 
    .EXTOp(EXTOp), 
    .O(EXT_out)
    );
	
   D_NPC NPC (
	 .Req(Req),
	 .eret(eret),    //有点乱风格了
	 .EPC(EPC_in),
    .PC(PC_out), 
	 .PC_F(PC_in),
    .IMM(IR_out[25:0]), 
    .RA(RD1_out), 
    .NPCOp(NPCOp), 
	 //output
    .NPC(NPC_out)
    );
	 
endmodule
