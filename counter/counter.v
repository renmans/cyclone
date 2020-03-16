module counter (
    input clk,
    output reg [3:0] out
);
    reg [24:0] q;
    
    always @(posedge clk)
        q <= q + 1;
    
    always @(posedge q[24])
        out <= out + 1;

endmodule
