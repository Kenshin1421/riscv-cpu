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
            4'b0000: begin //Add
                res = srcA + srcB;
            end

            4'b0001: begin //Sub 
                res = srcA - srcB;
            end

            4'b0010: begin //SLL
                res = srcA << srcB[4:0];
            end
        endcase 
    end

    assign zero = (res == 0);
    assign negative = res[31];

endmodule