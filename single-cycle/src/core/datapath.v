module datapath(
    input clk,
    input reset,
    input regWrite,
    input memWrite,
    input aluSrcA,
    input aluSrcB,
    input [2:0] immSrc,
    input [3:0] aluCtrl,
    input [1:0] resSrc,
    input [1:0] pcSrc,
    output [31:0] instOut,
    output zero,
    output negative,
    output overflow,
    output borrow
);

    wire [31:0] currInstAddress;
    wire [31:0] nextInstAddress;
    wire [31:0] pcFour;
    wire [31:0] branchOff;
    wire [31:0] instruction;
    wire [31:0] data;
    wire [31:0] dataFormatted;
    wire [31:0] rs1;
    wire [31:0] rs2;
    wire [31:0] storeFormatted;
    wire [31:0] immediate;
    wire [31:0] aluInA;
    wire [31:0] aluInB;
    wire [31:0] aluRes;
    wire [31:0] writeBack;

    wire [3:0] byteMask;

    //Architectural State Elements
    ProgramCounter pc(.clk(clk), .reset(reset), .PCNext(nextInstAddress), .PC(currInstAddress));
    InstructionMemory instMem(.PC(currInstAddress), .instruction(instruction));
    RegisterFile regFile(.clk(clk), .reset(reset), .regWrite(regWrite), .A1(instruction[19:15]), .A2(instruction[24:20]), .A3(instruction[11:7]), .WD(writeBack), .RD1(rs1), .RD2(rs2));
    DataMemory dataMem(.clk(clk), .memWrite(memWrite), .address(aluRes), .byteMask(byteMask), .WD(storeFormatted), .RD(data));

    //Main Computational Elements
    ALU alu(.srcA(aluInA), .srcB(aluInB), .aluCtrl(aluCtrl), .res(aluRes), .zero(zero), .negative(negative), .overflow(overflow), .borrow(borrow));
    ImmediateGenerator immGen(.instr(instruction[31:7]), .immSrc(immSrc), .extendedImm(immediate));
    storeFormatter sFormatter(.store(rs2), .storeCtrl(instruction[14:12]), .res2Lsb(aluRes[1:0]), .sFormatted(storeFormatted), .byteMask(byteMask));
    loadFormatter lFormatter(.load(data), .loadCtrl(instruction[14:12]), .res2Lsb(aluRes[1:0]), .lFormatted(dataFormatted));

    //Path Helper Elements
    adder_32bit pcPlusFour(.srcA(currInstAddress), .srcB(32'd4), .res(pcFour));
    adder_32bit pcBranch(.srcA(currInstAddress), .srcB(immediate), .res(branchOff));
    mux_2to1 aluA(.srcA(rs1), .srcB(currInstAddress), .sel(aluSrcA), .out(aluInA));
    mux_2to1 aluB(.srcA(rs2), .srcB(immediate), .sel(aluSrcB), .out(aluInB));
    mux_4to1 wbMux(.srcA(aluRes), .srcB(dataFormatted), .srcC(pcFour), .srcD(immediate), .sel(resSrc), .out(writeBack));
    mux_4to1 pcMux(.srcA(pcFour), .srcB(branchOff), .srcC(aluRes), .sel(pcSrc), .out(nextInstAddress));

    assign instOut = instruction;

    

endmodule