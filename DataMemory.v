module memory #(parameter integer data_width = 32, parameter integer address_width = 10)
(
	input clk,we,
	input [address_width-1:0] addr,
	input [data_width-1:0] data_in,
	output reg [data_width-1:0] data_out
);

reg [data_width-1:0] mem [2**address_width-1:0];

always @ (posedge clk)
begin
	if(we)
		mem[addr] <= data_in;
	else
		data_out <= mem[addr];
end

endmodule