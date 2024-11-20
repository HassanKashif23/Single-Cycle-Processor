module programcounter #(parameter integer datawidth = 32)
(
    input clk,rst,
    input [31:0]offset,
    output reg [datawidth-1:0] pc
);

always @ (posedge clk)
begin
    if(!rst)
    pc <= 0;
    else
    pc <= pc + offset;
end
endmodule