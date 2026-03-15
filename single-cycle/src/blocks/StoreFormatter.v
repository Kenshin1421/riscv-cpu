module storeFormatter(input [31:0] store, input [2:0] storeCtrl, input [1:0] res2Lsb, output reg [31:0] sFormatted, output reg [3:0] byteMask);
    always @(*) begin
        case(storeCtrl)
            3'b000: begin //SB
                sFormatted = store << 8*res2Lsb;
                byteMask = 4'b0001 << res2Lsb;
            end 
            3'b001: begin //SH
                sFormatted = store << 16*res2Lsb[1];
                byteMask = 4'b0011 << 2*res2Lsb[1];
            end
            3'b010: begin //SW
                sFormatted = store;
                byteMask = 4'b1111;
            end
        endcase        
    end
endmodule