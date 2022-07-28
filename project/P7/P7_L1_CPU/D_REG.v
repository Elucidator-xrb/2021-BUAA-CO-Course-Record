`timescale 1ns / 1ps

module D_REG(
    input Clk,
    input Rst,
    input We,
	 input Req,
	 input BD_in,
    input [31:0] IR_in,
    input [31:0] PC_in,
	 input [4:0] ExcCode_in,
	 output reg BD_out,
    output reg [31:0] IR_out,
    output reg [31:0] PC_out,
	 output reg [4:0] ExcCode_in
    );

	always @(posedge Clk) begin
		if(Rst | Req) begin
			BD_out <= 0;
			IR_out <= 0;
			PC_out <= Req ? 32'h0000_4180 : 0;
			ExcCode_out <= 5'd31; // `Exc_Null
		end else if(We == 1) begin
			BD_out <= BD_in;
			IR_out <= IR_in;
			PC_out <= PC_in;
			ExcCode_out <= ExcCode_in;
		end
	end
	
	initial begin
		BD_out = 0;
		IR_out = 0;
		PC_out = 0;
		ExcCode_out = 5'd31;
	end

endmodule
