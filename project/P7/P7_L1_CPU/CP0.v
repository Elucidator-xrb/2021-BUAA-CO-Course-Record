`timescale 1ns / 1ps

module CP0(
    input Clk,
    input Rst,
    input We,
    input [4:0] A1,			// read: Reg No.
    input [4:0] A2,			// write:Reg No.
	 input BDIn,
    input [31:0] DIn,
    input [31:0] PCIn,
    input [4:0] ExcCodeIn,
    input [5:0] HWInt,
    input EXLSet,
    input EXLClr,
    output Req,
    output [31:0] EPCOut,
    output [31:0] DOut
    );
	wire IntReq, ExtReq, EPC_tmp;
	reg [31:0] CP0reg[31:0];
	integer i;
	//reg [31:0] BadVAddr, Count, Status, Cause, PrID, EPCreg;
	
`define BadVAddr	CP0reg[8]
`define Count 		CP0reg[9]
`define Status		CP0reg[12]
`define Cause		CP0reg[13]
`define EPCreg		CP0reg[14]
`define PrID		CP0reg[15]

`define IM	`Status[15:10]	// Interupt Musk: correspond to 6 peripherals' interupt, 1-request enabled ; 0-disabled
`define EXL	`Status[1]		// Exception Level£º 1-allow interupt while in exception ; 0-forbid 
`define IE	`Status[0]		// Interupt Enabled: (global)

`define BD	`Cause[31]		// Branch Delay: 1-in delay slot
`define IP	`Cause[15:10]	// Interupt Pending: 6 peripherals' interupt per bit, 1-has interupt
`define ExcCode `Cause[6:2]// indicate exception type

	assign IntReq = |(HWInt & `IM) && ~`EXL && `IE;
	assign ExtReq = |ExcCodeIn && ~`EXL;
	assign Req = IntReq | ExtReq;
	
	assign EPCOut	= (Req != 1) ? EPCreg 	:
						  (BDIn == 1)? PCIn - 4 : PCIn ;
	
	assign DOut = CP0reg[A1];
	
	always @(posedge Clk, posedge Rst) begin
		if(Rst == 1) begin
			for(i = 0;i < 32;i = i+1) CP0reg[i] <= 0;
			`Status <= 32'h0040_0000;	//consider bev(Status[22])=1
			`PrID <= 32'h2022_1106;		//fake
		end else begin
			`IP <= HWInt;
			if(EXLClr == 1) `EXL <= 0;
			if(Req == 1) begin
				`EXL <= 1;
				`ExcCode <= IntReq ? 0 : ExcCodeIn;
				`EPCreg <= EPCOut;
			end
			if(Req == 0 && We == 1) CP0reg[A2] <= DIn; //mtc0 while not in Req
		end
	end	
	
	initial begin
		for(i = 0;i < 32;i = i+1) CP0reg[i] <= 0;
		`Status <= 32'h0040_0000;	//consider bev(Status[22])=1
		`PrID <= 32'h2022_1106;		//fake
	end

endmodule
