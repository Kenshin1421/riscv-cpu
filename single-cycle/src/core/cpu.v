module cpu(input clk, input reset);
    //Control wires
    wire [31:0] instruction;
    wire regWrite;
    wire memWrite;
    wire aluSrcB;
    wire [2:0] immSrc;
    wire [3:0] aluCtrl;
    wire [1:0] resSrc;

    datapath DP(
        .clk(clk),
        .reset(reset),
        .regWrite(regWrite),
        .memWrite(memWrite),
        .aluSrcB(aluSrcB),
        .immSrc(immSrc),
        .aluCtrl(aluCtrl), 
        .resSrc(resSrc),
        .instOut(instruction)
    );
    
    control_unit CU(
        .opcode(instruction[6:0]), 
        .funct3(instruction[14:12]), 
        .funct7(instruction[31:25]), 
        .regWrite(regWrite),
        .memWrite(memWrite),
        .aluSrcB(aluSrcB),
        .immSrc(immSrc),
        .aluCtrl(aluCtrl),
        .resSrc(resSrc)
    );
endmodule