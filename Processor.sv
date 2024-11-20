`include "Fetch.sv"
`include "Decode.sv"
`include "Execute.sv"
`include "Memory.sv"
`include "Writeback.sv"

module processor
(
	input clk,rst
);

wire [31:0] instruction,result;
  wire [31:0] rf_wdata,mem_data,alu_result;
wire rf_wen,mem_en;
wire [31:0] operand1,operand2;
wire [6:0] operation;
  wire [31:0]mem_data;
  wire branch;
  wire [31:0]store_data;
  wire [31:0]data_in,data_out;

fetch fu
(
	.clk(clk),
	.rst(rst),
	.branch(branch),
	.branch_offset(operand2),
    .instruction(instruction)
);

decodeunit du 
(
	.clk(clk),
	.rst(rst),
	.rf_wen(rf_wen),
	.mem_en(mem_en),
	.rdaddr(rdaddr),
    .rf_wdata(rf_wdata),
	.instruction(instruction),
    .operation(operation),
    .operand1(operand1),
    .operand2(operand2),
	.store_data(store_data)
);

execution eu
(
	.operand1(operand1),
	.operand2(operand2),
	.operation(operation),
	.branch(branch),
	.result(result)
);

memory mu
(
	.clk(clk),
	.we(mem_en),
	.addr(addr),
	.data_in(store_data),
	.data_out(data_out)
);

write_back wb
(
	.alu_result(result),
	.mem_data(data_out),
	.operation(operation),
	.rf_we(rf_wen),
	.rf_wdata(rf_wdata)
);
endmodule
