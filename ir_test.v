module ir_test(
	input clk_50_,
	input dout_,
	output adc_cs_n_,
	output din_,
	output adc_sck_,
	
	output led1_,
	output led2_,
	output led3_
	);
	
	reg led1,led2,led3;
	wire [11:0]ir1;
	wire [11:0]ir2;
	wire [11:0]ir3;
	assign led1_ = led1;
	assign led2_ = led2;
	assign led3_ = led3;
	
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
	
	
	always @ (posedge clk_50_)	begin
		if(ir1 > 12'b011111111111)
			led1 <= 1'b1;
		else
			led1 <= 1'b0;
		
		if(ir2 > 12'b011111111111)
			led2 <= 1'b0;
		else
			led2 <= 1'b1;
		
		if(ir3 > 12'b011111111111)
			led3 <= 1'b0;
		else
			led3 <= 1'b1;
	end
	
	endmodule