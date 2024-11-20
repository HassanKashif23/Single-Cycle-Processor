module reg_file #(parameter integer size = 32, parameter integer datawidth = 32)
(
	input clk,rst,
	//read ports
	input [4:0] rs1_addr,rs2_addr,
	output reg [datawidth-1:0] rs1_data,rs2_data,
	//write port
	input [4:0] rd_addr,
	input [datawidth-1:0] rd_data,   //from write back
	input wren   //from write back
	);
	
	reg [datawidth-1:0] regs [size-1:0];
	integer i;
	
	//read operation
	
	always @(posedge clk)
	begin
		rs1_data <= (rs1_addr != 0) ? regs[rs1_addr] : 0;
		rs2_data <= (rs2_addr != 0) ? regs[rs2_addr] : 0;
	end
	
	//write operation
	always @(posedge clk)
	begin
		if(rst)
		for (i=0;i<size;i=i+1)
		begin
		regs[i] <= {datawidth{1'b0}};
		end
		// regs <= 32'b0;
		else if(wren)
		regs[rd_addr] <= rd_data;
	end
	
	endmodule