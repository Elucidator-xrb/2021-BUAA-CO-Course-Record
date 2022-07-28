`timescale 1ns / 1ps

module E_REG(
    input Clk,
    input Rst,
    input We,
    input [31:0] IR_in,
    input [31:0] PC_in,
    input [31:0] EXT_in,
    input [31:0] V1_in,
    input [31:0] V2_in,
	 input [4:0] ExcCode_in,
	 input [1:0] ACmpB_in,
	 input [1:0] ACmp0_in,
	 output reg BD_out,
    output reg [31:0] IR_out,
    output reg [31:0] PC_out,
    output reg [31:0] EXT_out,
    output reg [31:0] V1_out,
    output reg [31:0] V2_out,
	 output reg [4:0] ExcCode_out,
	 output reg [1:0] ACmpB_out,
	 output reg [1:0] ACmp0_out 
    );

   always @(posedge Clk) begin
		if(Rst | Stall | Req) begin
			BD_out  <= Stall ? BD_in : 0;
			IR_out  <= 0;
         PC_out  <= Stall ? PC_in : (Req ? 32'h0000_4180 : 0);
         EXT_out <= 0;
         V1_out  <= 0;
         V2_out  <= 0;
			ExcCode_out <= 5'd31;
			ACmpB_out <= 0;
			ACmp0_out <= 0;
		end else if(We == 1) begin
			BD_out  <= BD_in;
         IR_out  <= IR_in;
         PC_out  <= PC_in;
         EXT_out <= EXT_in;
         V1_out  <= V1_in;
         V2_out  <= V2_in;
			ExcCode_out <= ExcCode_in;
			ACmpB_out <= ACmpB_in;
			ACmp0_out <= ACmp0_in;
      end
	end
	 
	initial begin
		BD_out = 0;
		IR_out = 0;
      PC_out = 0;
      EXT_out = 0;
      V1_out  = 0;
      V2_out  = 0;
		ExcCode_out = 5'd31;
		ACmpB_out = 0;
		ACmp0_out = 0;
	end

endmodule
