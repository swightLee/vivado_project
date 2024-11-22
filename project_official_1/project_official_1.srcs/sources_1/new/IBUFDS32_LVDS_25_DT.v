`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    13:08:20 03/06/06
// Design Name:    
// Module Name:    IBUF32_LVDS_DT
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
module IBUFDS32_LVDS_25_DT(I, IB, O);
    input [31:0] I;
    input [31:0] IB;
    output [31:0] O;

	 IBUFDS_LVDS_25_DT inst00(
	 		.I(I[0]),
			.IB(IB[0]),
			.O(O[0])
			);
	 IBUFDS_LVDS_25_DT inst01(
	 		.I(I[1]),
			.IB(IB[1]),
			.O(O[1])
			);
	 IBUFDS_LVDS_25_DT inst02(
	 		.I(I[2]),
			.IB(IB[2]),
			.O(O[2])
			);
	 IBUFDS_LVDS_25_DT inst03(
	 		.I(I[3]),
			.IB(IB[3]),
			.O(O[3])
			);
	 IBUFDS_LVDS_25_DT inst04(
	 		.I(I[4]),
			.IB(IB[4]),
			.O(O[4])
			);
	 IBUFDS_LVDS_25_DT inst05(
	 		.I(I[5]),
			.IB(IB[5]),
			.O(O[5])
			);
	 IBUFDS_LVDS_25_DT inst06(
	 		.I(I[6]),
			.IB(IB[6]),
			.O(O[6])
			);
	 IBUFDS_LVDS_25_DT inst07(
	 		.I(I[7]),
			.IB(IB[7]),
			.O(O[7])
			);
	 IBUFDS_LVDS_25_DT inst08(
	 		.I(I[8]),
			.IB(IB[8]),
			.O(O[8])
			);
	 IBUFDS_LVDS_25_DT inst09(
	 		.I(I[9]),
			.IB(IB[9]),
			.O(O[9])
			);
	 IBUFDS_LVDS_25_DT inst10(
	 		.I(I[10]),
			.IB(IB[10]),
			.O(O[10])
			);
	 IBUFDS_LVDS_25_DT inst11(
	 		.I(I[11]),
			.IB(IB[11]),
			.O(O[11])
			);
	 IBUFDS_LVDS_25_DT_INV inst12(	 //inverted
	 		.I(I[12]),
			.IB(IB[12]),
			.O(O[12])
			);
	 IBUFDS_LVDS_25_DT inst13(
	 		.I(I[13]),
			.IB(IB[13]),
			.O(O[13])
			);
	 IBUFDS_LVDS_25_DT inst14(
	 		.I(I[14]),
			.IB(IB[14]),
			.O(O[14])
			);
//all below inverted
	 IBUFDS_LVDS_25_DT_INV inst15(
	 		.I(I[15]),
			.IB(IB[15]),
			.O(O[15])
			);
	 IBUFDS_LVDS_25_DT_INV inst16(
	 		.I(I[16]),
			.IB(IB[16]),
			.O(O[16])
			);
	 IBUFDS_LVDS_25_DT_INV inst17(
	 		.I(I[17]),
			.IB(IB[17]),
			.O(O[17])
			);
	 IBUFDS_LVDS_25_DT_INV inst18(
	 		.I(I[18]),
			.IB(IB[18]),
			.O(O[18])
			);
	 IBUFDS_LVDS_25_DT_INV inst19(
	 		.I(I[19]),
			.IB(IB[19]),
			.O(O[19])
			);
	 IBUFDS_LVDS_25_DT_INV inst20(
	 		.I(I[20]),
			.IB(IB[20]),
			.O(O[20])
			);
	 IBUFDS_LVDS_25_DT_INV inst21(
	 		.I(I[21]),
			.IB(IB[21]),
			.O(O[21])
			);
	 IBUFDS_LVDS_25_DT_INV inst22(
	 		.I(I[22]),
			.IB(IB[22]),
			.O(O[22])
			);
	 IBUFDS_LVDS_25_DT_INV inst23(
	 		.I(I[23]),
			.IB(IB[23]),
			.O(O[23])
			);
	 IBUFDS_LVDS_25_DT_INV inst24(
	 		.I(I[24]),
			.IB(IB[24]),
			.O(O[24])
			);
	 IBUFDS_LVDS_25_DT_INV inst25(
	 		.I(I[25]),
			.IB(IB[25]),
			.O(O[25])
			);
	 IBUFDS_LVDS_25_DT_INV inst26(
	 		.I(I[26]),
			.IB(IB[26]),
			.O(O[26])
			);
	 IBUFDS_LVDS_25_DT_INV inst27(
	 		.I(I[27]),
			.IB(IB[27]),
			.O(O[27])
			);
	IBUFDS_LVDS_25_DT_INV inst28(
	 		.I(I[28]),
			.IB(IB[28]),
			.O(O[28])
			);
	 IBUFDS_LVDS_25_DT_INV inst29(
	 		.I(I[29]),
			.IB(IB[29]),
			.O(O[29])
			);
	 IBUFDS_LVDS_25_DT_INV inst30(
	 		.I(I[30]),
			.IB(IB[30]),
			.O(O[30])
			);
	 IBUFDS_LVDS_25_DT_INV inst31(
	 		.I(I[31]),
			.IB(IB[31]),
			.O(O[31])
			);


endmodule
