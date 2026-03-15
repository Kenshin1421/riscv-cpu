module mux_2to1(input [31:0] srcA, input [31:0] srcB, input sel, output reg [31:0] out);
    always @(*) begin
        case(sel)
            1'b0: out = srcA;
            1'b1: out = srcB;
        endcase
    end
endmodule