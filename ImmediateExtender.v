module imm_ext #(parameter integer data_width = 32)
(
	input [11:0] imm,
	output reg [data_width-1:0] extended
);

always @(*)
begin
	extended = {{data_width-12{imm[11]}},imm};
end

endmodule