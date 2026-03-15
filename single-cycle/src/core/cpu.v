module cpu(input clk, input reset);
    //Control wires
    wire [31:0] instruction;
    wire regWrite;
    wire aluSrcB;
    wire [2:0] immSrc;
    wire [3:0] aluCtrl;

    datapath DP(
        .clk(clk),
        .reset(reset),
        .regWrite(regWrite),
        .aluSrcB(aluSrcB),
        .immSrc(immSrc),
        .aluCtrl(aluCtrl), 
        .instOut(instruction)
    );
    
    control_unit CU(
        .opcode(instruction[6:0]), 
        .funct3(instruction[14:12]), 
        .funct7(instruction[31:25]), 
        .regWrite(regWrite),
        .aluSrcB(aluSrcB),
        .immSrc(immSrc),
        .aluCtrl(aluCtrl)
    );
endmodule