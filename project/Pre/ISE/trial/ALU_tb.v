`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:10:28 09/29/2021
// Design Name:   ALU
// Module Name:   D:/0_Personal File/Grade2_01_Autumn/CO/ISE/trial/ALU_tb.v
// Project Name:  trial
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_tb;

	// Inputs
	reg [3:0] inA;
	reg [3:0] inB;
	reg [1:0] op;
	reg clk;
	reg en;

	// Outputs
	wire [3:0] ans;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.inA(inA), 
		.inB(inB),  
		.op(op), 
		.clk(clk),
		.en(en),
		.ans(ans)
	);

	initial begin
		inA = 0; inB = 0;
		op = 0;
		clk = 0; en = 0;
		
		#10;
		en = 1;
		inA = 4'b1011;
		inB = 4'b0010;
		
		#20;
		op = 2'b01;
		#10;
		op = 2'b10;
		#10;
		op = 2'b11;
		
		#20;
		en = 1'b0;
		inA = 4'b0101;
	end

/* 	initial begin            
        $dumpfile("ALU_tb.vcd");        //生成的vcd文件名称
        $dumpvars(0, ALU_tb);    //tb模块名称
    end  */
	
	always #5 clk = ~clk;
      
endmodule

