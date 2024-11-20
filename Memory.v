`include "DataMemory.v"

module memory_unit
(
	input clk,we,
	input [31:0] addr,  //from ALU
	input [31:0] data_in,
	output wire [31:0] data_out
);

memory #(.data_width(32), .address_width(10)) data_mem
(
	.clk(clk),
	.we(we),
	.addr(addr),
	.data_in(data_in),
	.data_out(data_out)
);
endmodule