`timescale 1ns / 1ps
module control_and_state(WRCTRL,RDCTRL,CLK_40_BUFFERED,FRST,TXUSRCLK2,ACK,MYDIR,MYEN,
								DATA,STATUS,CONTROL,FRST_RESYNC,TRANSMIT_ON,FIFO_RST,FRST_PIN_OUT);


input wire WRCTRL,RDCTRL,CLK_40_BUFFERED,FRST,TXUSRCLK2;
output wire ACK,MYDIR,MYEN,FRST_PIN_OUT;
inout wire [15:0] DATA;
input wire [7:0] STATUS;
output reg [7:0] CONTROL = 8'b0000_0000;
output reg FRST_RESYNC = 1'b0;
output reg TRANSMIT_ON = 1'b0;
output reg FIFO_RST = 1'b0;

reg wrclt_temp = 1'b1;
reg wrctrl_delay = 1'b1;
reg [1:0] frst_temp = 2'b00;
reg frst_checked =1'b0;
reg [4:0]frst_counter = 5'b0_0000;
reg counter_en = 1'b0;

always @ (posedge CLK_40_BUFFERED)
	begin
	    wrclt_temp <= WRCTRL;
		wrctrl_delay <= wrclt_temp;
	end
	
always @ (posedge CLK_40_BUFFERED)
	begin
		if (wrctrl_delay & !wrclt_temp) CONTROL[7:0] = DATA[15:8];
	end

assign DATA[7:0] = RDCTRL ? 8'bzzzz_zzzz : STATUS;
assign DATA[15:8] = RDCTRL ? 8'bzzzz_zzzz : CONTROL;

assign ACK = wrctrl_delay & RDCTRL;
assign MYDIR = !RDCTRL;
assign MYEN =  WRCTRL & RDCTRL;

always @ (posedge CLK_40_BUFFERED)
	begin
		frst_temp[1] <= frst_temp[0];
		frst_temp[0] <= !FRST;			 //inverted
	end

always @ (posedge CLK_40_BUFFERED)
	begin
		if (!frst_temp[0] & !frst_temp[1]) frst_checked = 1'b0;
		else if (frst_temp[0] & frst_temp[1]) frst_checked = 1'b1;
	end

always @ (posedge CLK_40_BUFFERED)
	begin
		if (frst_checked)	
			begin
				counter_en <= 1'b1;
				frst_counter <= 5'b0_0000;
				FIFO_RST <= 1'b1;
				TRANSMIT_ON <= 1'b0;
			end
		else if (counter_en == 1'b1)
			begin
				frst_counter <= frst_counter + 1;
				if (frst_counter == 5'b0_1000) FIFO_RST <= 1'b0;
				if (frst_counter == 5'b1_1111)
					begin
						TRANSMIT_ON <= 1'b1;
						counter_en <= 1'b0;
					end
			end
	end

always @ (posedge TXUSRCLK2)
	begin
		FRST_RESYNC <= frst_checked;
	end

assign FRST_PIN_OUT = frst_temp[0];
endmodule
