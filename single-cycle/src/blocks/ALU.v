module ALU(
    input [31:0] srcA, 
    input [31:0] srcB,
    input [3:0] aluCtrl,
    output reg [31:0] res,
    output zero,
    output negative
);

    always @(*) begin
        res = 0;
        case(aluCtrl)
            4'b0000: begin
                res = srcA + srcB;
            end
        endcase 
    end

    assign zero = (res == 0);
    assign negative = res[31];

endmodule