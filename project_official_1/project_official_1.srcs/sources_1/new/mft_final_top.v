`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Engineer: YPLU
//
// Create Date:    10:26:17 09/26/06
// Design Name: 	 MFT_fpga_design   
// Module Name:    mft_final_top
// Project Name:   MFT
// Target Device:  xc2vp2_fg256
// Tool versions:  ISE7.1.04i
// Revision 0.01 - File Created
// Additional Comments:	insert testing data from xuhao, and optimize	dataflow to reduce delay 
////////////////////////////////////////////////////////////////////////////////
module mft_final_top(				

											sysclk_p,//125
											sysclk_n,
											refclk_875_p,refclk_875_n,
											FRST,
											WRCTRL,
											RDCTRL,							
											HIT,HITB,
//											CLK_40,CLK_40B,		//not use		
//											TRANSMIT_ON,		//jumper short for '0'
//											FRST_PIN_OUT,		//
//											REFCLKP,REFCLKN,		
											RXN,RXP,
											TXN,TXP,
											ACK,
											RUN_LED,
											ERR_LED,
											MYDIR,
											MYEN,
											DATA,
//											stretch_rst,
											out_hit0);

	 input wire sysclk_p,sysclk_n;
	 input wire refclk_875_p,refclk_875_n;
	 input wire FRST,WRCTRL,RDCTRL;
//	 input wire stretch_rst;
	 output wire out_hit0;	                        //*************************************************************
	 input wire [31:0] HIT,HITB; 
//	 input wire CLK_40,CLK_40B;        //not use
//    output wire FRST_PIN_OUT,TRANSMIT_ON;
//	 input wire REFCLKP,REFCLKN;   
	 input wire RXN,RXP; 
	 output wire TXN,TXP;
	 output wire ACK;
	 output wire RUN_LED,ERR_LED;
	 output wire MYDIR,MYEN;	 
	 inout wire [15:0] DATA;  
	
	wire stretch_rst;
    wire FRST_PIN_OUT,TRANSMIT_ON;
    wire clk_125_in;
    wire reset;
	wire clk_40_buffered;
	wire clk_40_locked;
	wire clk_125_buf;
	wire txusrclk,rxusrclk,txusrclk2,rxusrclk2,refclk_in;
	wire [7:0] status;
	wire [7:0] control;
	wire frst_resync,fifo_rst;
	wire stretcher_rst,test_bit,prbs_bit;
	wire [2:0] rom_select;
	wire fifo_overflow,fifo_underflow,refclk_locked,tx_buffer_err;
	wire [31:0] test_data;
	wire [31:0]	hits_stretched;
	wire [31:0] data_out_fifo;
	wire prog_empty;
	(*mark_debug = "true"*)wire [3:0] data_or_k;
	(*mark_debug = "true"*)wire [31:0]	data_to_mgt;
	wire TXCTRL_OUT;
	
	     IBUFDS #(
      .DIFF_TERM("TRUE"),       // Differential Termination
//      .IBUF_LOW_PWR("FALSE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("LVDS_25")     // Specify the input I/O standard
   ) IBUFDS_inst (
      .O(clk_125_in),  // Buffer output                                                 output IS 125Mhz
      .I(sysclk_p),  // Diff_p buffer input (connect directly to top-level port)
      .IB(sysclk_n) // Diff_n buffer input (connect directly to top-level port)
   );

    
    clk_40_buf INST_CLK_BUF(
    .clk_40_buf(clk_40_buffered),
    .reset(reset),
    .locked_40(clk_40_locked),
    .clk_125_buf(clk_125_buf),
    .clk_in(clk_125_in));
    
 

control_and_state INST_CONTROL_STATE (
    .WRCTRL(WRCTRL), 
    .RDCTRL(RDCTRL), 
    .CLK_40_BUFFERED(clk_40_buffered), 
    .FRST(FRST), 
    .TXUSRCLK2(txusrclk2), 
    .ACK(ACK), 
    .MYDIR(MYDIR), 
    .MYEN(MYEN), 
    .DATA(DATA), 
    .STATUS(status), 
    .CONTROL(control), 
    .FRST_RESYNC(frst_resync), 
    .TRANSMIT_ON(1'b1),
//    .TRANSMIT_ON(TRANSMIT_ON), 
    .FIFO_RST(fifo_rst), 
    .FRST_PIN_OUT(FRST_PIN_OUT)
    );
assign status[7:0] = {4'b0000,fifo_overflow,fifo_underflow,refclk_locked,tx_buffer_err};
assign rom_select[2:0] = control[2:0];
assign prbs_bit = control[4];
assign test_bit = control[5];
assign stretcher_rst = stretch_rst;//*************************************control[6];
//control_word mapping
//D15			D14			D13			D12			D11			D10			D09			D08
//N/A	stretcher_rst	 test_bit	prbs_bit			N/A	rom_select[2] rom_select[1] rom_select[0]
//
//state_word mapping
//D07			D06			D05			D04			D03			D02			D01			D00
//N/A			N/A			N/A			N/A	 fifo_overflow	 underflow	refclk_locked	tx_buffer_err
assign ERR_LED = !(fifo_overflow | fifo_underflow | !refclk_locked | tx_buffer_err);
assign RUN_LED = test_bit;

test_data_generator INST_TEST_GENERATOR (
//    .PRBS_BIT(prbs_bit), 
//    .TEST_BIT(test_bit), 
    .PRBS_BIT(1'b0), 
    .TEST_BIT(1'b1), 
    .CLK_40_BUFFERED(clk_40_buffered), 
    .TRANSMIT_ON(1'b1),
//    .TRANSMIT_ON(TRANSMIT_ON),
    .TEST_DATA(test_data), 
    .TXCTRL_OUT(TXCTRL_OUT)
    );

hits_buffer_stretch INST_HITS_BUF_STRETCHER (
    .HIT(HIT), 
    .HITB(HITB), 
    .CLOCK(clk_40_buffered), 
    .RESET(stretcher_rst), 
    .HITS_STRETCHED(hits_stretched),
	 .hitout_0(out_hit0)		 //*************************************************
    );

fifo_instantiation INST_FIFO (
    .TEST_DATA(test_data), 
    .HITS_STRETCHED(hits_stretched), 
    .TXUSRCLK2(txusrclk2), 
    .TRANSMIT_ON(1'b1),
//    .TRANSMIT_ON(TRANSMIT_ON), 
    .FIFO_RST(fifo_rst), 
    .CLK_40_BUFFERED(clk_40_buffered), 
    .TEST_BIT(1'b1), 
//    .TEST_BIT(test_bit), 
    .DATA_OUT_FIFO(data_out_fifo), 
    .FIFO_OVERFLOW_REG(fifo_overflow), 
    .FIFO_UNDERFLOW_REG(fifo_underflow), 
    .PROG_EMPTY(prog_empty)
    );

k_inserter INST_K_INSERTER (
    .FRST_RESYNC(frst_resync), 
    .TXUSRCLK2(txusrclk2), 
    .PROG_EMPTY(prog_empty), 
    .DATA_OUT_FIFO(data_out_fifo), 
    .DATA_OR_K(data_or_k), 
    .DATA_TO_MGT(data_to_mgt)
    );

gtwizard_0_exdes inst_gt(
    .Q0_CLK1_GTREFCLK_PAD_N_IN(refclk_875_n),
    .Q0_CLK1_GTREFCLK_PAD_P_IN(refclk_875_p),
    .clk_125_buf(clk_125_buf),
    .TXCTRL_IN(data_or_k),
    .DATA_FIFO_OUT_GT_IN(data_to_mgt),
    .RXN_IN(RXN),
    .RXP_IN(RXP),
    .TXN_OUT(TXN),
    .TXP_OUT(TXP),
    .gt0_rxusrclk2_i(txusrclk2)
    );

    
//   GT_CUSTOM GT_CUSTOM_INST (
//   								  .BREFCLK(1'b0), 
//                             .BREFCLK2(refclk_in), 
//                             .CHBONDI(4'b0000), 
//                             .CONFIGENABLE(1'b0), 
//                             .CONFIGIN(1'b0), 
//                             .ENCHANSYNC(1'b0), 
//                             .ENMCOMMAALIGN(1'b1), 
//                             .ENPCOMMAALIGN(1'b1), 
//                             .LOOPBACK(2'b00), 
//                             .POWERDOWN(1'b0), 
//                             .REFCLK(1'b0), 
//                             .REFCLKSEL(1'b1), 
//                             .REFCLK2(1'b0), 
//                             .RXN(RXN), 
//                             .RXP(RXP), 
//                             .RXPOLARITY(1'b1), 		//reverse polarity
//                             .RXRESET(1'b1), 
//                             .RXUSRCLK(rxusrclk), 
//                             .RXUSRCLK2(rxusrclk2), 
//                             .TXBYPASS8B10B(4'b0000), 
//                             .TXCHARDISPMODE(4'b0000), 
//                             .TXCHARDISPVAL(4'b0000), 
//                             .TXCHARISK(data_or_k), 
//                             .TXDATA(data_to_mgt), 
//                             .TXFORCECRCERR(1'b0), 
//                             .TXINHIBIT(1'b0), 
//                             .TXPOLARITY(1'b1), 		//reverse polarity
//                             .TXRESET(1'b0),	//frst_resync
//                             .TXUSRCLK(txusrclk), 
//                             .TXUSRCLK2(txusrclk2), 
//                             .CHBONDDONE(), 
//                             .CHBONDO(), 
//                             .CONFIGOUT(), 
//                             .RXBUFSTATUS(), 
//                             .RXCHARISCOMMA(), 
//                             .RXCHARISK(), 
//                             .RXCHECKINGCRC(), 
//                             .RXCLKCORCNT(), 
//                             .RXCOMMADET(), 
//                             .RXCRCERR(), 
//                             .RXDATA(), 
//                             .RXDISPERR(), 
//                             .RXLOSSOFSYNC(), 
//                             .RXNOTINTABLE(), 
//                             .RXREALIGN(), 
//                             .RXRECCLK(), 
//                             .RXRUNDISP(), 
//                             .TXBUFERR(tx_buffer_err), 
//                             .TXKERR(), 
//                             .TXN(TXN), 
//                             .TXP(TXP), 
//                             .TXRUNDISP()
//                             ); 
									  

                             
endmodule
