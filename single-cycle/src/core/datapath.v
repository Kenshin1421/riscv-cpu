module datapath(
    input clk,
    input reset,
    input regWrite,
    input aluSrcB,
    input [2:0] immSrc,
    input [3:0] aluCtrl,
    output [31:0] instOut
);

    wire [31:0] currInstAddress;
    wire [31:0] nextInstAddress;
    wire [31:0] instruction;
    wire [31:0] rs1;
    wire [31:0] rs2;
    wire [31:0] immediate;
    wire [31:0] aluInB;
    wire [31:0] writeBack;

    //Architectural State Elements
    ProgramCounter pc(.clk(clk), .reset(reset), .PCNext(nextInstAddress), .PC(currInstAddress));
    InstructionMemory instMem(.PC(currInstAddress), .instruction(instruction));
    RegisterFile regFile(.clk(clk), .reset(reset),.regWrite(regWrite), .A1(instruction[19:15]), .A2(instruction[24:20]), .A3(instruction[11:7]), .WD(writeBack), .RD1(rs1), .RD2(rs2));

    //Main Computational Elements
    ALU alu(.srcA(rs1), .srcB(aluInB), .aluCtrl(aluCtrl), .res(writeBack));
    ImmediateGenerator immGen(.instr(instruction[31:7]), .immSrc(immSrc), .extendedImm(immediate));

    //Path Helper Elements
    adder_32bit pcPlusFour(.srcA(currInstAddress), .srcB(32'd4), .res(nextInstAddress));
    mux_2to1 aluB(.srcA(rs2), .srcB(immediate), .sel(aluSrcB), .out(aluInB));

    assign instOut = instruction;

    

endmodule