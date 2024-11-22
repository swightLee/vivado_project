`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    09:34:47 06/05/2006 
// Module Name:    stretcher 
//////////////////////////////////////////////////////////////////////////////////
module stretcher(SIG_IN,RESET,SIG_OUT,CLOCK);

input wire SIG_IN,RESET,CLOCK;
output reg SIG_OUT = 1'b0;

reg sig_out_temp = 1'b0;
reg sig_out_temp1 = 1'b0;
reg sig_out_temp2 = 1'b0;
wire clear;
reg [4:0] counter_temp = 5'b10100;

assign clear = RESET | sig_out_temp2;
always @ (posedge SIG_IN,posedge clear)
	begin
		if (clear) sig_out_temp <= 1'b0;
		else sig_out_temp <= 1'b1;
	end

always @ (posedge CLOCK)
	begin
		sig_out_temp1 <= sig_out_temp;
	end
	
always @ (negedge CLOCK)
	begin
		sig_out_temp2 <= sig_out_temp1;
	end												


always @ (posedge CLOCK)
	begin 
		if (sig_out_temp1) 
			begin
				SIG_OUT = 1'b1;
				counter_temp <= 5'b0;
			end
		else if (counter_temp < 5'b10100) 
			begin
				counter_temp <= counter_temp + 1;
				SIG_OUT = 1'b1;
			end
		else SIG_OUT = 1'b0;
	end

endmodule
