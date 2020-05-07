module diff_hz (
    input clk,
    input key_slow,
    input key_fast,
    output reg [3:0] led
);

    reg [1:0] mode;
    reg [25:0] delay;
    reg key_slow_state;
    reg key_fast_state;

    debouncer ks(.clk(clk), .key_slow(key), .key_slow_state(key_state));
    debouncer kf(.clk(clk), .key_fast(key), .key_fast_state(key_state));

    reg [3:0] led_slow;
    reg [3:0] led_fast;

    always @(posedge clk)
    begin
        delay <= delay + 26'd1;

        if (delay[24])
            led_fast <= 4'hF;
        else
            led_fast <= 4'h0;

        if (delay[25])
            led_slow <= 4'hF;
        else
            led_slow <= 4'h0;
    end

    always @(posedge clk)
    begin
        mode[0] <= key_slow_state;
        mode[1] <= key_fast_state;
        case (mode)
            0: led <= 4'h0;
            1: led <= led_slow;
            2: led <= led_fast;
            3: led <= 4'hF;
        endcase
    end

endmodule
