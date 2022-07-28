`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:13:44 11/13/2021 
// Design Name: 
// Module Name:    DM 
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
module DM(
	 input [31:0] PC, //为打印信号而传入
    input Clk,
    input Rst,
    input [31:0] A,
    input [31:0] WD,
    input DMWr,
    input [1:0] SSel,
    input [1:0] LSel,
    output [31:0] RD
    );
	integer handle;
	 
	reg [31:0] DM[0:1023];
	wire [9:0] addr;
	wire [31:0] lwData, swData,shData,sbData;
	wire [15:0] lhData;
	wire [7:0] 	lbData;
	wire [31:0] WDReal_addr, WDReal_A; //WDReal_addr是适配addr的内容，WDReal_A是适配A的内容
	integer i;
	
	assign addr = A[11:2]; //在DM处是大小是控制好的,A是完整地址信号（Byte），addr是字地址信号（4Byte），对应DM索引
	
	assign lwData = DM[addr];
	assign lhData = (A[1] == 1'b0) ? DM[addr][15:0] : DM[addr][31:16];
	assign lbData = (A[1:0] == 2'b00) ? DM[addr][7:0]	:
						 (A[1:0] == 2'b01) ? DM[addr][15:8] :
						 (A[1:0] == 2'b10) ? DM[addr][23:16]:
						 (A[1:0] == 2'b11) ? DM[addr][31:24]: -1;
	assign RD = (LSel == 2'b00) ? lwData :
					(LSel == 2'b01) ? {{16{lhData[15]}},lhData} :
					(LSel == 2'b10) ? {{24{lbData[7]}} ,lbData} : -1;
					
	assign swData = WD;
	assign shData = (A[1] == 1'b0) ? {DM[addr][31:16],WD[15:0]} : {WD[15:0],DM[addr][15:0]};
	assign sbData = (A[1:0] == 2'b00) ? {DM[addr][31:8] ,WD[7:0]} :
						 (A[1:0] == 2'b01) ? {DM[addr][31:16],WD[7:0], DM[addr][7:0]} :
						 (A[1:0] == 2'b10) ? {DM[addr][31:24],WD[7:0],DM[addr][15:0]} :
						 (A[1:0] == 2'b11) ? {WD[7:0],DM[addr][23:0]} : -1;
	assign WDReal_addr = (SSel == 2'b00) ? swData :
								(SSel == 2'b01) ? shData :
								(SSel == 2'b10) ? sbData : -1;
	assign WDReal_A = (SSel == 2'b00) ? WD 		:
							(SSel == 2'b01) ? WD[15:0] :
							(SSel == 2'b10) ? WD[7:0]  : -1;
	
	always @(posedge Clk) begin
		if(Rst == 1) begin
			for(i=0;i<1024;i=i+1)
				DM[i] <= 32'h0000_0000;
		end else if(DMWr == 1) begin
			DM[addr] <= WDReal_addr;
			$display("@%h: *%h <= %h", PC, A, WDReal_A);
			handle = $fopen("../msg_out_cpu.txt","a");
			$fdisplay(handle,"@%h: *%h <= %h", PC, A, WDReal_A);
			$fclose(handle);
		end
	end
	
	initial begin
		for(i=0;i<1024;i=i+1)
			DM[i] = 32'h0000_0000;
	end

endmodule
