module DataMemory(
    input clk,
    input memWrite,
    input [31:0] address,
    input [31:0] WD,
    output [31:0] RD
);
    reg [31:0] dataMemory [1023:0];
    assign RD = dataMemory[address[11:2]];

    always @(posedge clk) begin
        if(memWrite)
            dataMemory[address[11:2]] <= WD;
    end
endmodule