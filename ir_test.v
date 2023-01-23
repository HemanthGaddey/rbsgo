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
//		.d_out_ch5[0](ir1[0]),
//		.d_out_ch5[1](ir1[1]),
//		.d_out_ch5[2](ir1[2]),
//		.d_out_ch5[3](ir1[3]),
//		.d_out_ch5[4](ir1[4]),
//		.d_out_ch5[5](ir1[5]),
//		.d_out_ch5[6](ir1[6]),
//		.d_out_ch5[7](ir1[7]),
//		.d_out_ch5[8](ir1[8]),
//		.d_out_ch5[9](ir1[9]),
//		.d_out_ch5[10](ir1[10]),
//		.d_out_ch5[11](ir1[11]),
//		.d_out_ch6[0](ir2[0]),
//		.d_out_ch6[1](ir2[1]),
//		.d_out_ch6[2](ir2[2]),
//		.d_out_ch6[3](ir2[3]),
//		.d_out_ch6[4](ir2[4]),
//		.d_out_ch6[5](ir2[5]),
//		.d_out_ch6[6](ir2[6]),
//		.d_out_ch6[7](ir2[7]),
//		.d_out_ch6[8](ir2[8]),
//		.d_out_ch6[9](ir2[9]),
//		.d_out_ch6[10](ir2[10]),
//		.d_out_ch6[11](ir2[11]),
//		.d_out_ch7[0](ir3[0]),
//		.d_out_ch7[1](ir3[1]),
//		.d_out_ch7[2](ir3[2]),
//		.d_out_ch7[3](ir3[3]),
//		.d_out_ch7[4](ir3[4]),
//		.d_out_ch7[5](ir3[5]),
//		.d_out_ch7[6](ir3[6]),
//		.d_out_ch7[7](ir3[7]),
//		.d_out_ch7[8](ir3[8]),
//		.d_out_ch7[9](ir3[9]),
//		.d_out_ch7[10](ir3[10]),
//		.d_out_ch7[11](ir3[11])
	);
	
	
	always @ (posedge clk_50_)	begin
		if(ir1 > 12'd2047)
			led1 <= 1'b1;
		else
			led1 <= 1'b0;
		
		if(ir2 > 12'd2047)
			led2 <= 1'b1;
		else
			led2 <= 1'b0;
		
		if(ir3 > 12'd2047)
			led3 <= 1'b1;
		else
			led3 <= 1'b0;
	end
	
	endmodule