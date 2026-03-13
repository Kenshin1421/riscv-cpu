module RegisterFile(
    input clk,
    input regWrite,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    output [31:0] RD1,
    output [31:0] RD2
);

    reg [31:0] rFile [31:0];

    assign RD1 = rFile[A1];
    assign RD2 = rFile[A2];

    always @(posedge clk) begin
        if(regWrite & (A3 != 0))
            rFile[A3] <= WD;
    end

endmodule