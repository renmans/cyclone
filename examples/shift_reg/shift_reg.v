module shift_reg (
    input clk,
    input key,
    output reg [3:0] led
);

    reg key_state;
    debouncer db(.clk(clk), .key(key), .key_state(key_state));

    reg [23:0] led_delay;

    always @(posedge clk)
        led_delay <= led_delay + 24'd1;

    always @(posedge led_delay[23])
        led <= {led[2:0], key_state};

endmodule
