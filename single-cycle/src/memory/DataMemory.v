module DataMemory(
    input clk,
    input memWrite,
    input [31:0] address,
    input [3:0] byteMask,
    input [31:0] WD,
    output [31:0] RD
);
    reg [31:0] dataMemory [1023:0];
    assign RD = dataMemory[address[11:2]];

    always @(posedge clk) begin
        if(memWrite) begin
            if(byteMask[0])
                dataMemory[address[11:2]][7:0] <= WD[7:0];
            if(byteMask[1])
                dataMemory[address[11:2]][15:8] <= WD[15:8];
            if(byteMask[2])
                dataMemory[address[11:2]][23:16] <= WD[23:16];
            if(byteMask[3])
                dataMemory[address[11:2]][31:24] <= WD[31:24];
        end
    end

    initial begin
        dataMemory[0] = 32'h11223344;
        dataMemory[1] = 32'h55667788;
    end
endmodule