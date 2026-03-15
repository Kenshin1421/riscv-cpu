module mux_4to1(input [31:0] srcA, input [31:0] srcB, input [31:0] srcC, input [31:0] srcD, input [1:0] sel, output reg [31:0] out);
    always @(*) begin
        case(sel)
            2'b00: out = srcA;
            2'b01: out = srcB;
            2'b10: out = srcC;
            2'b11: out = srcD;
        endcase
    end
endmodule