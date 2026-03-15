module datapath(
    input clk,
    input reset,
    input regWrite,
    input [3:0] aluCtrl,
    output [31:0] instOut
);

    wire [31:0] currInstAddress;
    wire [31:0] nextInstAddress;
    wire [31:0] instruction;
    wire [31:0] rs1;
    wire [31:0] rs2;
    wire [31:0] writeBack;

    ProgramCounter pc(.clk(clk), .reset(reset), .PCNext(nextInstAddress), .PC(currInstAddress));
    InstructionMemory instMem(.PC(currInstAddress), .instruction(instruction));
    RegisterFile regFile(.clk(clk), .reset(reset),.regWrite(regWrite), .A1(instruction[19:15]), .A2(instruction[24:20]), .A3(instruction[11:7]), .WD(writeBack), .RD1(rs1), .RD2(rs2));

    adder_32bit pcPlusFour(.srcA(currInstAddress), .srcB(32'd4), .res(nextInstAddress));

    ALU alu(.srcA(rs1), .srcB(rs2), .aluCtrl(aluCtrl), .res(writeBack));

    assign instOut = instruction;

    

endmodule