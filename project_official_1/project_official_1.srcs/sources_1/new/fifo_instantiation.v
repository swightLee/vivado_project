`timescale 1ns / 1ps

module fifo_instantiation(TEST_DATA,HITS_STRETCHED,TXUSRCLK2,TRANSMIT_ON,FIFO_RST,CLK_40_BUFFERED,
								TEST_BIT,DATA_OUT_FIFO,FIFO_OVERFLOW_REG,FIFO_UNDERFLOW_REG,PROG_EMPTY);
input wire [31:0] TEST_DATA;
input wire [31:0] HITS_STRETCHED;
output wire [31:0] DATA_OUT_FIFO;
input wire  TXUSRCLK2,CLK_40_BUFFERED,TEST_BIT,TRANSMIT_ON,FIFO_RST;
output wire PROG_EMPTY;
output reg FIFO_OVERFLOW_REG,FIFO_UNDERFLOW_REG;

wire [31:0] data_in_fifo = TEST_BIT ? TEST_DATA : HITS_STRETCHED;
wire overflow,underflow;
wire full,empty;
wire prog_full;

//fifo_cg INST_FIFO_CG (
//    .din(data_in_fifo),
//    .rd_clk(TXUSRCLK2),
//    .rd_en(!PROG_EMPTY),
//    .rst(FIFO_RST),
//    .wr_clk(CLK_40_BUFFERED),
//    .wr_en(TRANSMIT_ON),
//    .dout(DATA_OUT_FIFO),
//    .empty(empty),
//    .full(full),
//    .overflow(overflow),
//    .prog_empty(PROG_EMPTY),
//    .underflow(underflow));
        fifo_cg INST_FIFO_CG (
          .rst(FIFO_RST),                // input wire rst
          .wr_clk(CLK_40_BUFFERED),          // input wire wr_clk
          .rd_clk(TXUSRCLK2),          // input wire rd_clk
          .din(data_in_fifo),                // input wire [31 : 0] din
          .wr_en(TRANSMIT_ON),            // input wire wr_en
          .rd_en(!PROG_EMPTY),            // input wire rd_en
          .dout(DATA_OUT_FIFO),              // output wire [31 : 0] dout
          .full(full),              // output wire full
          .overflow(overflow),      // output wire overflow
          .empty(empty),            // output wire empty
          .underflow(underflow),    // output wire underflow
          .prog_full(prog_full),    // output wire prog_full
          .prog_empty(PROG_EMPTY)  // output wire prog_empty
        );
        
//        fifo_cg your_instance_name (
//  .rst(rst),                // input wire rst
//  .wr_clk(wr_clk),          // input wire wr_clk
//  .rd_clk(rd_clk),          // input wire rd_clk
//  .din(din),                // input wire [31 : 0] din
//  .wr_en(wr_en),            // input wire wr_en
//  .rd_en(rd_en),            // input wire rd_en
//  .dout(dout),              // output wire [31 : 0] dout
//  .full(full),              // output wire full
//  .overflow(overflow),      // output wire overflow
//  .empty(empty),            // output wire empty
//  .underflow(underflow),    // output wire underflow
//  .prog_full(prog_full),    // output wire prog_full
//  .prog_empty(prog_empty)  // output wire prog_empty
//);

always @ (posedge CLK_40_BUFFERED)
	begin
		if (FIFO_RST) FIFO_OVERFLOW_REG = 1'b0;
		else if (overflow) FIFO_OVERFLOW_REG = 1'b1;
	end

always @ (posedge CLK_40_BUFFERED)
	begin
		if (FIFO_RST) FIFO_UNDERFLOW_REG = 1'b0;
		else if (underflow) FIFO_UNDERFLOW_REG = 1'b1;
	end

endmodule
