module write_back
(
	input [31:0] alu_result,
	input [31:0] mem_data,
	input [6:0] operation,
	output reg rf_we,
	output reg [31:0]rf_wdata
);

always @ (*)
begin
	if((operation == 26) | (operation == 27) | (operation == 28) | (operation == 29) | (operation == 30))
	begin
		rf_wdata = mem_data;
		rf_we = 1;
	end
	else begin
		rf_wdata = alu_result;
		rf_we = 1;
	end
end

endmodule