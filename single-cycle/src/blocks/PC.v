module ProgramCounter(
    input clk,
    input reset,
    input [31:0] PCNext,
    output [31:0] PC
);

    reg [31:0] currPc;

    always @(posedge clk) begin
        if(reset)
            currPc <= 32'b0;
        else
            currPc <= PCNext;    
    end

    assign PC = currPc;
endmodule