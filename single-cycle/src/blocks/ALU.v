module ALU(
    input [31:0] srcA, 
    input [31:0] srcB,
    input [3:0] aluCtrl,
    output reg [31:0] res,
    output zero,
    output negative,
    output overflow,
    output borrow
);
    wire [31:0] res_sub;
    assign res_sub = srcA - srcB;

    always @(*) begin
        res = 0;
        case(aluCtrl)
            4'b0000: res = srcA + srcB; //Add
            4'b0001: res = res_sub; //Sub
            4'b0010: res = srcA << srcB[4:0]; //SLL
            4'b0011: res = {31'b0, res_sub[31]^overflow}; //SLT
            4'b0100: res = srcA < srcB; //SLTU
            4'b0101: res = srcA^srcB; //XOR
            4'b0110: res = srcA >> srcB[4:0]; //SRL
            4'b0111: res = $signed(srcA) >>> srcB[4:0]; //SRA
            4'b1000: res = srcA | srcB;  //OR
            4'b1001: res = srcA & srcB; //AND
        endcase 
    end

    assign zero = (res == 0);
    assign negative = res[31];
    assign overflow = (srcA[31] != srcB[31]) && (res_sub[31] != srcA[31]);
    assign borrow = srcA < srcB; 

endmodule