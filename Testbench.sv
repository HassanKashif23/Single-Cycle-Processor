`timescale 1ns/1ns
`include "Processor.sv"

module processor_tb;

	bit clk;
	bit rst;

processor risc
(
	.clk(clk),
	.rst(rst)
);

initial begin
  clk = 1'b0;
  forever #5 clk = ~clk;
end 

initial 
begin
	rst = 1'b0;
	#30 rst = 1'b1;
end

initial 
begin
	$dumpfile("processor.vcd");
	$dumpvars(0,processor_tb);
	#150 $finish;
end

endmodule
