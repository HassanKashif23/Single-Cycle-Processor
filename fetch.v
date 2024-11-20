`include "IM.v"
`include "PC.v"

module fetch
(
    input clk,
    input wire rst,
    input branch,
    input [31:0]branch_offset,
    output wire [31:0]instruction

);

wire [31:0]pc_im;
wire [31:0]pc_offset;

always @ (*)
begin
    if(branch)
    pc_offset = branch_offset << 1;
    else
    pc_offset = 1;
end 

instr_mem #( .addresswidth(32), .datawidth(32)) IM
(
    .clk(clk),
    .address(pc_im),
    .instruction(instruction)
);

programcounter #(.datawidth(32)) PC
(
    .clk(clk),
    .rst(rst),
    .offset(offset),
    .pc(pc_im)
);

endmodule