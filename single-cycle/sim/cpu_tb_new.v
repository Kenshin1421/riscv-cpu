module cpu_tb;
    reg clk;
    reg reset;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    cpu  DUT(.clk(clk), .reset(reset));

    initial begin
        reset = 1;
        #15 reset = 0;
        #100 $finish;
    end


    always @(posedge clk) begin
       $display("Time: %0t | clk edge detected", $time); 
    end
endmodule