`timescale 1ns / 1ps


module clk_40_buf(

    output wire clk_40_buf,
//    inout wire clk_in1_p,
//    inout wire clk_in1_n,
    inout wire reset,
    output wire locked_40,
    output wire clk_125_buf,
    input wire clk_in
    );
    
//    wire clk_40_buf_i;
//    wire clk_125_buf_i;


      clk_buf_40 instance_name
   (
    // Clock out ports
    .clk_out1(clk_40_buf),     // output clk_out1
    .clk_out2(clk_125_buf),
    // Status and control signals
    .reset(reset), // input reset
    .locked(locked_40),       // output locked
   // Clock in ports
    .clk_in1(clk_in)
    );// input clk_in1_n
    

endmodule
