`timescale 1ns / 1ps
module k_inserter(FRST_RESYNC,TXUSRCLK2,PROG_EMPTY,DATA_OUT_FIFO,DATA_OR_K,DATA_TO_MGT);

input wire FRST_RESYNC,TXUSRCLK2,PROG_EMPTY;
input wire [31:0] DATA_OUT_FIFO;
output reg [3:0] DATA_OR_K;
output reg [31:0] DATA_TO_MGT;
//output reg [3:0] DATA_OR_K = 4'b1000;
//output reg [31:0] DATA_TO_MGT = 32'hBC95_B5B5;

//reg connect_done = 1'b0;
(*mark_debug = "true"*)reg  connecting = 1'b0;
reg [4:0] start_up_counter = 5'b00000;


/*always @ (posedge TXUSRCLK2)
	begin
		if (frst_resync_inv) start = 1'b1;
		else if (connect_done) start = 1'b0;
	end*/
always @ (posedge TXUSRCLK2)
	if (FRST_RESYNC)		//prior to start
		begin
				DATA_TO_MGT = 32'hBC95_B5B5;
				DATA_OR_K = 4'b1000;
				connecting = 1'b1;
				start_up_counter = 5'b00000;
		end
	else if (connecting)
		begin
			start_up_counter = start_up_counter + 1'b1;
			if (start_up_counter < 5'b01110)	
				begin
					DATA_TO_MGT = 32'hBC95_B5B5;
					DATA_OR_K = 4'b1000;
				end
			else if (start_up_counter < 5'b10000)	
				begin
					DATA_TO_MGT = 32'h1C95B5B5;
					DATA_OR_K = 4'b1000;
				end
			else if (start_up_counter < 5'b11101)	
				begin
					DATA_TO_MGT = 32'hBC95B5B5;
					DATA_OR_K = 4'b1000;
				end
			else if (start_up_counter < 5'b11110)	
				begin
					DATA_TO_MGT = 32'h7C95_B5B5;
					DATA_OR_K = 4'b1000;
				end
			else if (start_up_counter < 5'b11111)	
				begin
					DATA_TO_MGT = 32'h7C95_B5B5;
					DATA_OR_K = 4'b1000;
				end
			else 
				begin
					DATA_TO_MGT = 32'h7C95_B5B5;
					DATA_OR_K = 4'b1000;
					connecting = 1'b0;
				end					
		end
	else
		begin
			if (PROG_EMPTY)
				begin
					DATA_TO_MGT = 32'hBC95_B5B5;
					DATA_OR_K = 4'b1000;
				end
			else
				begin
					DATA_TO_MGT = DATA_OUT_FIFO;
					DATA_OR_K = 4'b0000;
				end
		end

endmodule
