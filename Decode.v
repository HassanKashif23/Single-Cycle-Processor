`include "Decodelogic.v"
`include "Registerfile.v"
`include "ImmediateExtender.v"

module decodeunit
(
    input clk,rst,rf_wen,
    input [31:0] rf_wdata, instruction,
    output wire mem_en,
    output wire [4:0] rdaddr,
    output wire [6:0]operation,
    output wire [31:0] operand1,
    output reg [31:0]operand2,
    output wire [31:0]store_data
);

wire [11:0]imm_wire;
wire [4:0]rs1addr,rs2addr;
wire [31:0]rs2_op2,extend;
wire i_type,b_type,l_type,s_type;

decode d
(
    .instruction(instruction),
    .i_type(i_type),
    .b_type(b_type),
    .l_type(l_type),
    .s_type(s_type),
    .rs1(rs1addr),  //wired to input of register file
    .rs2(rs2addr),  //wired to input of register file
    .rd(rdaddr),    //wired to input of register file
    .imm(imm_wire),  //wired to input of extender
    .operation(operation)     
);

reg_file #(.size(32), .datawidth(32)) rf
(
	.clk(clk),
    .rst(rst),
	.rs1_addr(rs1addr),   //wired to output of decode logic
    .rs2_addr(rs2addr),   //wired to output of decode logic
	.rs1_data(operand1),
    .rs2_data(rs2_op2),
	.rd_addr(rdaddr),     //wired to output of decode logic
	.rd_data(rf_wdata),
	.wren(rf_wen)
);

imm_ext #(.data_width(32)) ie
(
	.imm(imm_wire),
	.extended(extend)
);

always @ (*)
begin
    if(i_type | b_type | l_type | s_type)
    operand2 = extend;
    else
    operand2 = rs2_op2;
end

assign mem_en = s_type;
assign store_data = rs2_op2;

endmodule