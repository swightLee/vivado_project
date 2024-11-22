`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    17:01:09 06/05/2006 
// Module Name:    stretcher_32b 
//////////////////////////////////////////////////////////////////////////////////
module stretcher_32b(SIG_IN,RESET,SIG_OUT,CLOCK);

input wire [31:0]SIG_IN;
input wire RESET,CLOCK;
output wire [31:0]SIG_OUT;

wire [31:0]sig_in_tmp = SIG_IN;
wire reset_tmp = RESET;
wire clk_tmp = CLOCK;
wire [31:0]sig_out_tmp;
assign SIG_OUT = sig_out_tmp;

generate
genvar i;
	for (i=0;i<=31;i=i+1)
		begin : for_stretcher_generate
			stretcher STRETCHER_32INSTS(sig_in_tmp[i],reset_tmp,sig_out_tmp[i],clk_tmp);
		end
endgenerate
endmodule
