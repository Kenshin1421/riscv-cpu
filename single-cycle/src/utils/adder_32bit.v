module adder_32bit(
    input [31:0] srcA,
    input [31:0] srcB,
    output [31:0] res
);
    assign res = srcA+srcB;
endmodule