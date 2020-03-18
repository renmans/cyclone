module debouncer (
    input clk,
    input key,
    output reg key_state
);

    reg [1:0] key_sync;

    always @(posedge clk)
        key_sync <= {key_sync[0], ~key};

    reg [15:0] counter;

    wire key_change = (key_state != key_sync[1]);
    wire max_count = &counter;

    always @(posedge clk)
        if (key_change)
        begin
            counter <= counter + 16'd1;
            if (max_count)
                key_state = ~key_state;
        end
        else
            counter <= 0;

endmodule
