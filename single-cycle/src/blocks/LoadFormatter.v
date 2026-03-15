module loadFormatter(input [31:0] load, input [2:0] loadCtrl, input [1:0] res2Lsb, output reg [31:0] lFormatted);
    wire [7:0] byte;
    wire [15:0] half;
    assign byte = load[8*res2Lsb +: 8];
    assign half = load[16*res2Lsb[1] +: 16];
    always @(*) begin
        case(loadCtrl)
            3'b000: lFormatted = {{24{byte[7]}}, byte};//LB
            3'b001: lFormatted = {{16{half[15]}}, half};//LH
            3'b010: lFormatted = load; //LW
            3'b100: lFormatted = {{24{1'b0}}, byte}; //LBU
            3'b101: lFormatted = {{16{1'b0}}, half}; //LHU
        endcase
    end
endmodule