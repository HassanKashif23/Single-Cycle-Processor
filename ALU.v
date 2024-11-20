module ALU(
	input [31:0] operand1,operand2,
	input [6:0] operation,
	output reg [31:0] result
	);

always @ (*)
begin
	case(operation)
	7'b1,7'b1010,7'b11100,7'b100001     : result = operand1 + operand2;  //ADDI & loads & store
	7'b10,7'b1101    : result = $signed(operand1) < $signed(operand2) ? 1 : 0;  //SLTI
	7'b11,7'b1110    : result = operand1 < operand2 ? 1 : 0;  //SLTIU
	7'b100,7'b1111   : result = operand1 ^ operand2;  //XORI
	7'b101,7'b10010  : result = operand1 | operand2;  //ORI
	7'b110,7'b10011  : result = operand1 & operand2;  //ANDI
	7'b111,7'b1100   : result = operand1 << operand2[4:0];  //SLLI
	7'b1000,7'b10000 : result = operand1 >> operand2;  //SRLI
	7'b1001,7'b10001 : result = operand1 >>> operand2;  //SRAI
	7'b1011 : result = operand1 - operand2;  //SUB
	7'B10100 : result = (operand1 == operand2) ? 32'b1:32'b0;  //BEQ
	7'B10101 : result = (operand1 != operand2) ? 32'b1:32'b0;  //BNE
	7'B10110 : result = ($signed(operand1) < $signed(operand2)) ? 32'b1:32'b0;  //BLT
	7'B10111 : result = ($signed(operand1) >= $signed(operand2)) ? 32'b1:32'b0;  //BEG
	7'B11000 : result = (operand1 < operand2) ? 32'b1:32'b0;  //BLTU
	7'B11001 : result = (operand1 >= operand2) ? 32'b1:32'b0;  //BEGU

	default: result = 0;
	
	endcase
end

endmodule