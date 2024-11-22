`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    18:18:12 10/08/06
// Design Name:    
// Module Name:    hits_buffer_stretch
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module hits_buffer_stretch(HIT,HITB,CLOCK,RESET,HITS_STRETCHED,hitout_0);		//***************************

    input wire [31:0] HIT,HITB; 
	 input CLOCK;
    input RESET;
	 output wire hitout_0;	 //******************************************

    output [31:0] HITS_STRETCHED;

	 wire [31:0] hits;
IBUFDS32_LVDS_25_DT HITS_BUFFER_INST (
    .I(HIT), 
    .IB(HITB), 
    .O(hits)
    );

	 assign hitout_0 = hits[0];  //*****************************************
stretcher_32b HITS_STRETCH_INST (
    .SIG_IN(hits), 
    .RESET(RESET), 
    .SIG_OUT(HITS_STRETCHED), 
    .CLOCK(CLOCK)
    );



endmodule
