module output_led(

    input clk,

    input [11:0] data,

    input [1:0] sel,

    output reg [3:0] led = 4'b0000

);

parameter THRESHOLD = 12'd3000;

reg [25:0] blink_counter = 0;

reg blink = 0;

always @(posedge clk)
begin

    if(blink_counter == 26'd50000000)
    begin

        blink_counter <= 0;

        blink <= ~blink;

    end

    else
    begin

        blink_counter <= blink_counter + 1;

    end

end


always @(posedge clk)
begin

    led <= 4'b0000;

    if(data >= THRESHOLD)
    begin

        case(sel)

            2'b00: led <= {3'b000, blink};

            2'b01: led <= {2'b00, blink, 1'b0};

            2'b10: led <= {1'b0, blink, 2'b00};

            2'b11: led <= {blink, 3'b000};

        endcase

    end

end

endmodule
