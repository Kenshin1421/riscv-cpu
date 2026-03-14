module control_unit(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg regWrite,
    output reg [3:0] aluCtrl
);

    always @(*) begin
        regWrite = 0;
        aluCtrl = 0;
        case(opcode)
            7'b0110011: begin //R-Type Instruction
                case({funct7, funct3})
                    {7'b0000000, 3'b000}: begin
                        regWrite = 1'b1;
                        aluCtrl = 4'b0000;    
                    end
                endcase
            end
        endcase
    end

endmodule