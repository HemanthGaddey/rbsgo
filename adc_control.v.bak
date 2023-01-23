// SB : Task 2 A : ADC
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design ADC Controller.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//ADC Controller design
//Inputs  : clk_50 : 50 MHz clock, dout : digital output from ADC128S022 (serial 12-bit)
//Output  : adc_cs_n : Chip Select, din : Ch. address input to ADC128S022, adc_sck : 2.5 MHz ADC clock,
//				d_out_ch5, d_out_ch6, d_out_ch7 : 12-bit output of ch. 5,6 & 7,
//				data_frame : To represent 16-cycle frame (optional)

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module adc_control(
	input  clk_50,				//50 MHz clock
	input  dout,				//digital output from ADC128S022 (serial 12-bit)
	output adc_cs_n,			//ADC128S022 Chip Select
	output din,					//Ch. address input to ADC128S022 (serial)
	output adc_sck,			//2.5 MHz ADC clock
	output [11:0]d_out_ch5,	//12-bit output of ch. 5 (parallel)
	output [11:0]d_out_ch6,	//12-bit output of ch. 6 (parallel)
	output [11:0]d_out_ch7,	//12-bit output of ch. 7 (parallel)
	output [1:0]data_frame	//To represent 16-cycle frame (optional)
);
	
////////////////////////WRITE YOUR CODE FROM HERE////////////////////
reg [3:0] counter = 4'd0;
reg [11:0] data_counter = 12'd0;
reg [11:0] data_counter_p = 12'd0;
reg adc_clk_reg = 0;
reg data_clk_reg = 0;
reg [2:0] addr = 3'd5;
reg dout_reg = 0;
reg din_reg = 0;
reg [11:0] data = 12'd0;
reg [11:0] data5 = 12'd0;
reg [11:0] data6 = 12'd0;
reg [11:0] data7 = 12'd0;
reg csn = 1;

//For adc clock
assign adc_sck = adc_clk_reg;
//assign d_out_ch5 = data_clk_reg;
//assign d_out_ch7 = data;

assign d_out_ch5 = data5;
assign d_out_ch6 = data6;
assign d_out_ch7 = data7;
assign adc_cs_n = csn;
assign din = din_reg;

initial begin
counter = 4'd0;
data_counter = 12'd0;
end

always @ (negedge clk_50) begin
	if(counter == 4'd10)
	begin
		adc_clk_reg <= ~adc_clk_reg;
		counter <= 4'd1;
	end
	else
	begin
		counter<=counter+4'd1;
	end
end


//For data_counter
always @(negedge adc_sck) begin
	if(data_counter == 12'd15) begin
		data_counter <= 12'd0;
		data_clk_reg <= ~data_clk_reg;
		end
	else begin
		data_counter <= data_counter+12'd1;
	end
	
end

//For data_counter_p
always @(posedge adc_sck) begin
	if(data_counter_p == 12'd15) begin
		data_counter_p <= 12'd0;
		end
	else begin
		data_counter_p <= data_counter_p+12'd1;
	end
	
end

//For generating din
always @(negedge adc_sck) begin
	if(data_counter==12'd2) begin
		din_reg <= addr[2];
	end
	if(data_counter==12'd3) begin
		din_reg <= addr[1];
	end
	if(data_counter==12'd4) begin
		din_reg <= addr[0];
	end
	if(data_counter==12'd5) begin
		din_reg <= 0;
		
		if(addr == 3'd7) begin
			addr <= 3'd5;
		end
		else begin
			addr <= addr+3'd1;
		end
	end
end

//For taking dout input
always @ (negedge adc_sck) begin
	if(data_counter == 12'd0) begin
		data[0] <= dout;
		if(addr == 3'd7) begin
			data5 <= data;
		end
		if(addr == 3'd5) begin
			data6 <= data;
		end
		if(addr == 3'd6) begin
			data7 <= data;
		end
	end
	
	if(data_counter >= 12'd4) begin
		data[12'd16-data_counter] <= dout;
	end
end
// 111011011010 010001011110 011111001110 | 5-7 6-5 7-6
//For cs_n
always @(negedge adc_sck) begin
	if(data_counter == 12'd0) begin
		csn <= 0;
	end
end

always @(posedge adc_sck) begin
	if(data_counter_p == 12'd15) begin
		//csn <= 1;
	end
end
////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////