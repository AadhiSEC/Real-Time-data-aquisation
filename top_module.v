module top_module(

    input clk,

    input [1:0] sel,

    output [3:0] led,

    output [6:0] D0_SEG,
    output reg [3:0] D0_AN,

    output [6:0] D1_SEG,
    output reg [3:0] D1_AN

);


//=========================================================
// INTERNAL SIGNALS
//=========================================================

wire [11:0] proc_data;

wire wr_en;
wire rd_en;

wire [11:0] fifo_out;

wire full;
wire empty;

wire [11:0] mux_out;
wire [11:0] adc_data;


//=========================================================
// SAMPLE TICK
//=========================================================

reg [13:0] div_cnt = 0;

reg sample_tick = 0;

always @(posedge clk)
begin

    if(div_cnt == 14'd9999)
    begin

        div_cnt <= 0;

        sample_tick <= 1'b1;

    end

    else
    begin

        div_cnt <= div_cnt + 1;

        sample_tick <= 1'b0;

    end

end
wire [15:0] xadc_data;
wire drdy;
wire [4:0] channel_out;

reg [11:0] temp_data = 0;

xadc_wiz_0 xadc_inst (
.daddr_in(7'd0),
.dclk_in(clk),
.den_in(1'b1),
.di_in(16'd0),
.dwe_in(1'b0),
.reset_in(1'b0),
.busy_out(),
.channel_out(channel_out),
.do_out(xadc_data),
.drdy_out(drdy),
.eoc_out(),
.eos_out(),
.ot_out(),
.vccaux_alarm_out(),
.vccint_alarm_out(),
.user_temp_alarm_out(),
.alarm_out(),
.vp_in(1'b0),
.vn_in(1'b0)
);

//=========================================================
// REAL TEMPERATURE
//=========================================================

always @(posedge clk)
begin

    if(drdy)
    begin

        case(channel_out)

            5'h00:
            temp_data <= ((xadc_data[15:4] * 504) / 4096) - 273;

        endcase

    end

end


//=========================================================
// SENSOR VALUES
//=========================================================

reg [11:0] s0 = 12'd1000;
reg [11:0] s1 = 12'd1500;
reg [11:0] s2 = 12'd2500;
reg [11:0] s3 = 12'd3500;


always @(posedge sample_tick)
begin

    s0 <= s0 + 1;
    s1 <= s1 + 2;
    s2 <= s2 + 3;
    s3 <= s3 + 4;

end


//=========================================================
// MUX
//=========================================================

mux4x1 m1(

    .sensor0(s0),
    .sensor1(s1),
    .sensor2(s2),
    .sensor3(s3),

    .sel(sel),

    .mux_out(mux_out)

);


//=========================================================
// ADC
//=========================================================

adc_controller a1(

    .clk(clk),

    .sample_tick(sample_tick),

    .mux_out(mux_out),

    .adc_data(adc_data)

);


//=========================================================
// PROCESSING
//=========================================================

processing_unit p1(

    .clk(clk),

    .sample_tick(sample_tick),

    .adc_data(adc_data),

    .proc_data(proc_data)

);


//=========================================================
// FSM
//=========================================================

control_fsm c1(

    .clk(clk),

    .sample_tick(sample_tick),

    .wr_en(wr_en),

    .rd_en(rd_en)

);


//=========================================================
// FIFO
//=========================================================

fifo_buffer f1(

    .clk(clk),

    .sample_tick(sample_tick),

    .wr_en(wr_en),

    .rd_en(rd_en),

    .din(proc_data),

    .dout(fifo_out),

    .full(full),

    .empty(empty)

);


//=========================================================
// LED
//=========================================================

output_led o1(

    .clk(clk),

    .data(fifo_out),

    .sel(sel),

    .led(led)

);


//=========================================================
// BCD DIGITS
//=========================================================

wire [3:0] proc_thousands;
wire [3:0] proc_hundreds;
wire [3:0] proc_tens;
wire [3:0] proc_ones;

assign proc_thousands = (proc_data / 1000) % 10;
assign proc_hundreds  = (proc_data / 100) % 10;
assign proc_tens      = (proc_data / 10) % 10;
assign proc_ones      = proc_data % 10;


//=========================================================
// FAST DISPLAY REFRESH
//=========================================================

reg [12:0] refresh_counter = 0;

reg [1:0] digit_select = 0;

always @(posedge clk)
begin

    refresh_counter <= refresh_counter + 1;

    if(refresh_counter == 13'd1000)
    begin

        refresh_counter <= 0;

        digit_select <= digit_select + 1;

    end

end


//=========================================================
// LEFT DISPLAY = THRESHOLD 3000
//=========================================================

reg [3:0] d0_digit;

always @(*)
begin

    case(digit_select)

        2'b00:
        begin
            D0_AN = 4'b1110;
            d0_digit = 4'd0;
        end

        2'b01:
        begin
            D0_AN = 4'b1101;
            d0_digit = 4'd0;
        end

        2'b10:
        begin
            D0_AN = 4'b1011;
            d0_digit = 4'd0;
        end

        2'b11:
        begin
            D0_AN = 4'b0111;
            d0_digit = 4'd3;
        end

    endcase

end


//=========================================================
// RIGHT DISPLAY = PROC DATA
//=========================================================

reg [3:0] d1_digit;

always @(*)
begin

    case(digit_select)

        2'b00:
        begin
            D1_AN = 4'b1110;
            d1_digit = proc_ones;
        end

        2'b01:
        begin
            D1_AN = 4'b1101;
            d1_digit = proc_tens;
        end

        2'b10:
        begin
            D1_AN = 4'b1011;
            d1_digit = proc_hundreds;
        end

        2'b11:
        begin
            D1_AN = 4'b0111;
            d1_digit = proc_thousands;
        end

    endcase

end


//=========================================================
// DISPLAY DRIVERS
//=========================================================

seven_segment disp0(

    .digit(d0_digit),
    .seg(D0_SEG)

);


seven_segment disp1(

    .digit(d1_digit),
    .seg(D1_SEG)

);

Endmodule
