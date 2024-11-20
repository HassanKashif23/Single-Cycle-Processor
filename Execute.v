`include "ALU.v"

module execution(
	input [31:0] operand1,operand2,
	input [6:0] operation,
	output reg branch,
	output wire [31:0] result
	);

always @ (*)
begin
	branch = (operation == 20) | (operation == 21) | (operation == 22) | (operation == 23) | (operation == 24) | (operation == 25) && (result == 32'b1);
end

ALU alu 
(
	.operand1(operand1),
	.operand2(operand2),
	.operation(operation),
	.result(result)
);

endmodule