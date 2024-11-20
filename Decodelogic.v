module decode 
(
    input [31:0] instruction,
    output reg i_type,b_type,l_type,s_type,
    output reg [4:0] rs1,rs2,rd,
    output reg [11:0] imm,
    output reg [6:0]operation        //accroding to the instruction set
);

reg r_type;
reg [6:0]opcode;

always @ (*)
begin
    opcode = instruction[6:0];
end

always @ (*)
begin
    i_type = (opcode == 7'b0010011);
    r_type = (opcode == 7'b0110011);
    b_type = (opcode == 7'b1100011);
    l_type = (opcode == 7'b0000011);
    s_type = (opcode == 7'b0110011);
end

always @ (*)
begin
    // if(r_type) begin
        rs1 = instruction[19:15];
        rs2 = instruction[24:20];
        rd = instruction[11:7];
    // end else begin
    //     rs1 = 0;
    //     rs2 = 0;
    //     rd = 0;
    // end
end
//==================extracting immediate values=========
always @ (*)
begin
    if(i_type | l_type) begin
        imm = instruction[31:20];
    end 
    else if(b_type) begin
        imm = {instruction[31],instruction[7],instruction[30:25],instruction[11:8]};
    end 
    else if(s_type) begin
        imm = {instruction[31:25],instruction[11:7]};
    end else begin
        imm = 0;
    end
end

always @ (*)
begin
//======== for I Type Instructions ============
    case(opcode)
    7'b0010011 : begin  //I TYPE
        case(instruction[14:12])       //look for func3 in RV32I base instruction set chart
            3'b000 : operation <= 1; //ADDI
            3'b001 : operation <= 7; //SLLI
            3'b010 : operation <= 2; //SLTI
            3'b011 : operation <= 3; //SLTIU
            3'b100 : operation <= 4; //XORI
            3'b101 : operation <= (instruction[31:30] == 0) ? 8:9; //SRLI & SRAI
            3'b110 : operation <= 5; //ORI
            3'b111 : operation <= 6; //ANDI
            default : operation <= 0;  //INVALID INSTRUCTION
        endcase
    end
//======== for R Type Instructions ============
    7'b0110011 : begin  //R TYPE
        case(instruction[14:12])       //look for func3 in RV32I base instruction set chart
            3'b000 : operation <= (instruction[31:30] == 0) ? 10:11; //ADD & SUB
            3'b001 : operation <= 12; //SLL
            3'b010 : operation <= 13; //SLT
            3'b011 : operation <= 14; //SLTU
            3'b100 : operation <= 15; //XOR
            3'b101 : operation <= (instruction[31:30] == 0) ? 16:17; //SRL & SRA
            3'b110 : operation <= 18; //OR
            3'b111 : operation <= 19; //AND
            default : operation <= 0;  //INVALID INSTRUCTION
        endcase
    end
//======== for B Type Instructions ============
    case(opcode)
    7'b1100011 : begin  //B TYPE
        case(instruction[14:12])       //look for func3 in RV32I base instruction set chart
            3'b000 : operation <= 20; //BEQ
            3'b001 : operation <= 21; //BNE
            3'b100 : operation <= 22; //BLT
            3'b101 : operation <= 23; //BGE
            3'b110 : operation <= 24; //BLTU
            3'b111 : operation <= 25; //BGEU
            default : operation <= 0;  //INVALID INSTRUCTION
        endcase
    end
    //======== for Load Type Instructions ============
    case(opcode)
    7'b0000011 : begin  //L TYPE
        case(instruction[14:12])       //look for func3 in RV32I base instruction set chart
            3'b000 : operation <= 26; //LB
            3'b001 : operation <= 27; //LH
            3'b010 : operation <= 28; //LW
            3'b100 : operation <= 29; //LBU
            3'b101 : operation <= 30; //LHU
            default : operation <= 0;  //INVALID INSTRUCTION
        endcase
    end
    //======== for Store Type Instructions ============
    case(opcode)
    7'b0100011 : begin  //S TYPE
        case(instruction[14:12])       //look for func3 in RV32I base instruction set chart
            3'b000 : operation <= 31; //SB
            3'b001 : operation <= 32; //SH
            3'b010 : operation <= 33; //SW
            default : operation <= 0;  //INVALID INSTRUCTION
        endcase
    end
    default : operation <= 7'b0000000;  //INVALID INSTRUCTION
    endcase
end
endmodule

