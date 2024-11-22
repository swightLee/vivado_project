module IBUFDS_LVDS_25_DT_INV(I, IB, O);
    input I;
    input IB;
    output O;
	 wire temp;
   IBUFDS #(
      .DIFF_TERM("TRUE"),       // Differential Termination
      .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("LVDS_25_DT")     // Specify the input I/O standard
   ) IBUFDS_inst (
      .O(temp),  // Clock buffer output
      .I(I),  // Diff_p clock buffer input (connect directly to top-level port)
      .IB(IB) // Diff_n clock buffer input (connect directly to top-level port)
   );
	  assign O=!temp;

endmodule