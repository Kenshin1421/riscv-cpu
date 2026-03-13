module PC(input clk, input reset, input [31:0] PCNext, output [31:0] PC);
    reg [31:0] CurrPc;

    always @(posedge clk) begin
        if(reset)
            CurrPc <= 32'b0;
        else
            CurrPc <= PCNext;    
    end

    assign PC = CurrPc;
endmodule