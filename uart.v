// SB : Task 2 B : UART
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design UART Transmitter.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//UART Transmitter design
//Input   : clk_50M : 50 MHz clock
//Output  : tx : UART transmit output

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module uart(
	input clk_50M,	//50 MHz clock
	output tx,		//UART transmit output
	output reg ready,
	input [31:0]data,
	input start
);
//////////////////////////WRITE YOUR CODE FROM HERE////////////////////
reg [31:0] s = 32'b00111000001101110100001001010011; //01010011 01000010 00110111 00111000;
//reg [4:0] c = 5'd0;
reg tx_reg = 1;
reg baud_clk = 0;
reg [8:0] baud_counter = 9'd0;
reg [2:0]currentPacket = 5;
reg [3:0]packetState = 4'd11;//0 is start bit
								 //1-8 is data
								 //9-10 is end bit
								 //11-16 is not transmitting

reg [1:0]state = 0; //0 is waiting for start,
		// 1 is transmitting
		// 2 is transmission complete
assign tx = tx_reg;
//
//clock set according to baud rate
always @(negedge clk_50M) begin
	if(baud_counter == 9'd217) begin
		baud_counter <= 1;
		baud_clk <= ~baud_clk;
	end
	else begin
		baud_counter <= baud_counter + 9'd1;
	end
end

// transmitting data
always @(negedge baud_clk)begin
	if(state == 0) begin
		currentPacket = 0;
		state = 1;
	end
	else if (state == 1) begin
		if(currentPacket <= 'd4) begin
			if(packetState == 'd0)begin
				tx_reg = 1'b0;
				packetState = packetState + 'd1;
			end
			else if(packetState <= 'd8)begin
				tx_reg = s[0];
				s = {1'b1, s[31:1]};
				packetState = packetState + 'd1;
			end
			else if(packetState < 'd10) begin
				tx_reg = 1'b1;
				packetState = packetState + 'd1;
			end
			else begin
				packetState = 0;
				currentPacket = currentPacket + 1'b1;
			end
		end
		else begin
			tx_reg = 1'b1;
			state = 2;
		end
	end
	else begin
		if(start == 1) begin
			ready = 1'b0;
			state = 0;
			s = data;
		end
	end
end
	
////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////
