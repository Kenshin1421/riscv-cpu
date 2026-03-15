module control_unit(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg regWrite,
    output reg aluSrcB,
    output reg [2:0] immSrc,
    output reg [3:0] aluCtrl
);

    //Main decoder
    always @(*) begin
        regWrite = 0;
        aluSrcB = 0;
        immSrc = 0;

        case(opcode)
            7'b0110011: begin //R-Type Instruction
                regWrite = 1'b1;
                aluSrcB = 1'b0;
            end

            7'b0010011: begin //I-Type Instruction
                regWrite = 1'b1;
                immSrc = 3'b000;
                aluSrcB = 1'b1;
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
                    3'b001: aluCtrl = 4'b0010;
                    3'b010: aluCtrl = 4'b0011; 
                    3'b011: aluCtrl = 4'b0100;
                    3'b100: aluCtrl = 4'b0101;
                    3'b101: aluCtrl = (funct7[5] == 0)? 4'b0110:4'b0111; //SRL / SRA
                    3'b110: aluCtrl = 4'b1000;
                    3'b111: aluCtrl = 4'b1001;
                endcase
            end

            7'b0010011: begin //I-Type instructions
                case(funct3)
                    3'b000: aluCtrl = 4'b0000;
                endcase
            end
        endcase
    end

endmodule