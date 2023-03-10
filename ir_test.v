module ir_test(
	input clk_50_,
	input dout_,
	output adc_cs_n_,
	output din_,
	output adc_sck_,
	output tx_,
	
	output led1_,
	output led2_,
	output led3_,
	output led4_,
	output led5_,
	output led6_,
	output led7_,
	output led8_
	);
	
	integer ch5,ch6,ch7;
	reg led1,led2,led3,led4,led5,led6,led7,led8;
	wire [11:0]ir1;
	wire [11:0]ir2;
	wire [11:0]ir3;
	assign led1_ = led1;
	assign led2_ = led2;
	assign led3_ = led3;
	assign led4_ = led4;
	assign led5_ = led5;
	assign led6_ = led6;
	assign led7_ = led7;
	assign led8_ = led8;
	
	adc_control ac(
		.clk_50(clk_50_),
		.dout(dout_),
		.adc_cs_n(adc_cs_n_),
		.din(din_),
		.adc_sck(adc_sck_),
		.d_out_ch5(ir1),
		.d_out_ch6(ir2),
		.d_out_ch7(ir3)
	);
	
	wire ready_;
	reg start_ = 1;
	wire [31:0]data;
	reg [31:0]data_ = 32'b00000000000000000000000000000000;
	assign data = data_;
	uart xbee(
		.clk_50M(clk_50_),
		.tx(tx_),
		.start(start_),
		.data(data_)
	);
	
	//Message Transmission:
	//ADC bin->int
	always@(ir1) begin
		ch5 = ir1;
		data_ = ir1;
	end
	always @ (posedge clk_50_)	begin
		led1 <= 0;
		led2 <= 0;
		led3 <= 0;
		led4 <= (ir1 > 12'b000110011010)?1:0;
		led5 <= 0;
		led6 <= 0;
		led7 <= 0;
		led8 <= 0;
	end
	
	endmodule
