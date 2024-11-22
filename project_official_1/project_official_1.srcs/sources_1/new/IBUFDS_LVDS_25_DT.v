`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/12 10:44:07
// Design Name: 
// Module Name: IBUFDS_LVDS_25_DT
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IBUFDS_LVDS_25_DT(I, IB, O);
    input I;
    input IB;
    output O;

   IBUFDS #(
      .DIFF_TERM("TRUE"),       // Differential Termination
      .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("LVDS_25_DT")     // Specify the input I/O standard
) IBUFDS_inst (
      .O(O),  // Clock buffer output
      .I(I),  // Diff_p clock buffer input (connect directly to top-level port)
      .IB(IB) // Diff_n clock buffer input (connect directly to top-level port)
   );

endmodule
