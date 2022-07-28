//CMP
`define CMP_equal 2'b00
`define CMP_great 2'b01
`define CMP_small 2'b10

//NPCOp
`define NPC_order  2'b00
`define NPC_branch 2'b01
`define NPC_jump	 2'b10
`define NPC_reg	 2'b11

//EXTOp
`define EXT_zero 1'b0
`define EXT_sign 1'b1

//ALUASel
`define ALUA_rd1 2'b00
`define ALUA_shamt 2'b01
//ALUBSel
`define ALUB_rd2 2'b00
`define ALUB_imm 2'b01

//ALUOp
`define ALU_add 4'b0000
`define ALU_sub 4'b0001
`define ALU_or  4'b0010
`define ALU_lui 4'b0011
`define ALU_and 4'b0100
`define ALU_xor 4'b0101
`define ALU_nor 4'b0110
`define ALU_sll 4'b0111
`define ALU_srl 4'b1000
`define ALU_sra 4'b1001
`define ALU_slt 4'b1010
`define ALU_sltu 4'b1011

//HILOOp
`define HILO_mult  4'b0000
`define HILO_multu 4'b0001
`define HILO_div   4'b0010
`define HILO_divu  4'b0011
`define HILO_mfhi  4'b0100
`define HILO_mthi  4'b0101
`define HILO_mflo  4'b0110
`define HILO_mtlo  4'b0111

//EYSel
`define EY_hilo 2'b00
`define EY_alu  2'b01

//DMOp
`define DM_w 3'b000
`define DM_h 3'b001
`define DM_b 3'b010
`define DM_hu 3'b011
`define DM_bu 3'b100

//GRFA3Sel
`define GRFA3_rt 2'b00
`define GRFA3_rd 2'b01
`define GRFA3_31 2'b10
`define GRFA3_00 2'b11

//GRFWDSel
`define GRFWD_alu 2'b00
`define GRFWD_dm  2'b01
`define GRFWD_pc8 2'b10

//FASel FBSel
`define ForwardM 2'b10
`define ForwardW 2'b01