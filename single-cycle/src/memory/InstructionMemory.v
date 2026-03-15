module InstructionMemory(
    input [31:0] PC,
    output [31:0] instruction
);

    reg [31:0] instMemory [0:1023];
    assign instruction = instMemory[PC[11:2]];

    /*
        1024 * 4 bytes = 4KB Instruction memory
        Can support upto 1024 instructions

        Ignoring least 2 bits of PC as instructions are 4 bytes
        Taking only 10 bits of PC [11:2] for 1024 addresses
    */

    initial begin
        $readmemh("sim/program.hex", instMemory);
    end

endmodule