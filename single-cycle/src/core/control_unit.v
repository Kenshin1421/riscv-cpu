module control_unit(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg regWrite,
    output reg memWrite,
    output reg aluSrcB,
    output reg [2:0] immSrc,
    output reg [3:0] aluCtrl,
    output reg [1:0] resSrc
);

    //Main decoder
    always @(*) begin
        regWrite = 0;
        immSrc = 0;
        aluSrcB = 0;
        memWrite = 0;
        resSrc = 0;

        case(opcode)
            7'b0110011: begin //R-Type Instruction
                regWrite = 1'b1;
                immSrc = 3'b000; //Irrelevant , not actually used
                aluSrcB = 1'b0;
                memWrite = 1'b0;
                resSrc = 2'b00;
            end

            7'b0010011: begin //Computational I-Type Instruction
                regWrite = 1'b1;
                immSrc = 3'b000;
                aluSrcB = 1'b1;
                memWrite = 1'b0;
                resSrc = 2'b00;
            end

            7'b0000011: begin //Load Instructions
                regWrite = 1'b1;
                immSrc = 3'b000;
                aluSrcB = 1'b1;
                memWrite = 1'b0;
                resSrc = 2'b01;
            end

            7'b0100011: begin //Store Instructions
                regWrite = 1'b0;
                immSrc = 3'b001;
                aluSrcB = 1'b1;
                memWrite = 1'b1;
                resSrc = 2'b00; //Irrelevant as regWrite is not asserted.
            end
        endcase
    end

    //ALU Control decoder
    always @(*) begin
        aluCtrl = 0;
        case(opcode)
            7'b0110011: begin //R-type instructions
               case(funct3)
                    3'b000: aluCtrl = (funct7[5] == 0)? 4'b0000:4'b0001; //Add / SUB
                    3'b001: aluCtrl = 4'b0010; //SLL
                    3'b010: aluCtrl = 4'b0011; //SLT
                    3'b011: aluCtrl = 4'b0100; //SLTU
                    3'b100: aluCtrl = 4'b0101; //XOR
                    3'b101: aluCtrl = (funct7[5] == 0)? 4'b0110:4'b0111; //SRL / SRA
                    3'b110: aluCtrl = 4'b1000; //OR
                    3'b111: aluCtrl = 4'b1001; //AND
                endcase
            end

            7'b0010011: begin //I-Type instructions
                case(funct3)
                    3'b000: aluCtrl = 4'b0000; //ADDI
                    3'b001: aluCtrl = 4'b0010; //SLLI
                    3'b010: aluCtrl = 4'b0011; //SLTI
                    3'b011: aluCtrl = 4'b0100; //SLTIU
                    3'b100: aluCtrl = 4'b0101; //XORI
                    3'b101: aluCtrl = (funct7[5] == 0)? 4'b0110:4'b0111; //SRLI / SRAI
                    3'b110: aluCtrl = 4'b1000; //ORI
                    3'b111: aluCtrl = 4'b1001; //ANDI
                endcase
            end

            7'b0000011: aluCtrl = 4'b0000; //Load - Add
            
            7'b0100011: aluCtrl = 4'b0000; //Store - Add
        endcase
    end

endmodule