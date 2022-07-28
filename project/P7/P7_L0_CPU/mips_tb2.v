`timescale 1ns/1ps

module mips_tb2;

    reg clk;
    reg reset;

    wire [31:0] i_inst_addr;		//取出PC值 F_PC
    wire [31:0] i_inst_rdata;		//输回相应指令 F_instr

    wire [31:0] m_data_addr;		//取出将读写地址 IM:A
    wire [31:0] m_data_rdata;		//输回存储器相应地址内容 IM:RD_out
    wire [31:0] m_data_wdata;		//取出将读写内容 IM:WD
    wire [3 :0] m_data_byteen;	//取出四位字节使能
    wire [31:0] m_inst_addr;		//取出PC值 M_PC

    wire w_grf_we;
    wire [4:0] w_grf_addr;
    wire [31:0] w_grf_wdata;
    wire [31:0] w_inst_addr;

    mips_cpu mips(
        .clk(clk),
        .reset(reset),

        .i_inst_addr(i_inst_addr),
        .i_inst_rdata(i_inst_rdata),

        .m_data_addr(m_data_addr),
        .m_data_rdata(m_data_rdata),
        .m_data_wdata(m_data_wdata),
        .m_data_byteen(m_data_byteen),
        .m_inst_addr(m_inst_addr),

        .w_grf_we(w_grf_we),
        .w_grf_addr(w_grf_addr),
        .w_grf_wdata(w_grf_wdata),
        .w_inst_addr(w_inst_addr)
    );

    integer i; 
    reg [31:0] fixed_addr;
    reg [31:0] fixed_wdata;
    reg [31:0] data[0:4095];	//数据存储器
    reg [31:0] inst[0:4095];	//指令存储器

    assign m_data_rdata = data[m_data_addr >> 2];
    assign i_inst_rdata = inst[(i_inst_addr - 32'h3000) >> 2];

	integer handle;
	initial begin
		handle = $fopen("../msg_out_cpu.txt","w");
		$fclose(handle);
	end

    initial begin
		for (i = 0; i < 4096; i = i + 1) inst[i] = 0;
        $readmemh("code.txt", inst);
        for (i = 0; i < 4096; i = i + 1) data[i] = 0;
    end

    initial begin
        clk = 1;
        reset = 1;
        #1.25 reset = 0;
    end

    always @(*) begin
        fixed_wdata = data[m_data_addr >> 2];
        fixed_addr = m_data_addr & 32'hfffffffc;
        if (m_data_byteen[3]) fixed_wdata[31:24] = m_data_wdata[31:24];
        if (m_data_byteen[2]) fixed_wdata[23:16] = m_data_wdata[23:16];
        if (m_data_byteen[1]) fixed_wdata[15: 8] = m_data_wdata[15: 8];
        if (m_data_byteen[0]) fixed_wdata[7 : 0] = m_data_wdata[7 : 0];
    end

    always @(posedge clk) begin
        if (~reset) begin
            if (w_grf_we && (w_grf_addr != 0)) begin
                $display("%d@%h: $%d <= %h", $time, w_inst_addr, w_grf_addr, w_grf_wdata);
					 
					 handle = $fopen("../msg_out_cpu.txt","a");
                $fdisplay(handle, "@%h: $%d <= %h", w_inst_addr, w_grf_addr, w_grf_wdata);
					 $fclose(handle);
            end
        end
    end

    always @(posedge clk) begin
        if (reset) for (i = 0; i < 4096; i = i + 1) data[i] <= 0;
        else if (|m_data_byteen) begin
            data[fixed_addr >> 2] <= fixed_wdata;
            $display("%d@%h: *%h <= %h", $time, m_inst_addr, fixed_addr, fixed_wdata);
				
				handle = $fopen("../msg_out_cpu.txt","a");
            $fdisplay(handle, "@%h: *%h <= %h", m_inst_addr, fixed_addr, fixed_wdata);
				$fclose(handle);
        end
    end

    always #0.5 clk <= ~clk;

endmodule
