module instr_mem #(parameter integer addresswidth = 32 , parameter integer datawidth = 32)
(
    input clk,
    input [addresswidth-1:0]address,
    output reg [datawidth-1:0]instruction
);

reg [datawidth-1:0] mem [0:2**10-1];

initial begin
    $readmemh("Instructions.hex", mem);
end

always @ (posedge clk)
begin
    instruction <= mem[address];
end

endmodule