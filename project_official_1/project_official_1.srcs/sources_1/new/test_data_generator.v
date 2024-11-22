`timescale 1ns / 1ps

//module test_data_generator(ROM_SELECT,PRBS_BIT,TEST_BIT,CLK_40_BUFFERED,TEST_DATA,TRANSMIT_ON,TEST_DATA,TXCTRL_OUT);
module test_data_generator(PRBS_BIT,TEST_BIT,CLK_40_BUFFERED,TRANSMIT_ON,TEST_DATA,TXCTRL_OUT);
//input wire [2:0] ROM_SELECT;
input wire CLK_40_BUFFERED,TEST_BIT,PRBS_BIT,TRANSMIT_ON;
//output wire [31:0] TEST_DATA;
output reg [31:0] TEST_DATA;
output reg  [7:0] TXCTRL_OUT;

//reg [8:0] addr_counter = 9'b0_0000_0000;
//wire [8:0] temp = addr_counter;
//wire [191:0] rom_out_all;
//reg  [31:0]	rom_out_one;
//wire rom_en = TRANSMIT_ON & TEST_BIT & !PRBS_BIT;
reg [31:0] prbs = 32'h0000_0001;
wire            tied_to_ground_i;
wire             tied_to_vcc_i;
wire    [31:0]  tied_to_ground_vec_i;
//wire    [63:0]  tx_data_bram_i;
wire    [7:0]   tx_ctrl_i;
reg     [8:0]   read_counter_i = 8'b000000000;
reg     [79:0] rom [0:511];
reg     [79:0]  tx_data_ram_r;
//(* ASYNC_REG = "TRUE" *) (* keep = "true" *)    reg     system_reset_r; 
//(* ASYNC_REG = "TRUE" *) (* keep = "true" *)    reg     system_reset_r2; 


always@(posedge CLK_40_BUFFERED)
begin
	if(TRANSMIT_ON & TEST_BIT & PRBS_BIT) 
		begin
			prbs <= {prbs[30:0],prbs[0]^prbs[10]^prbs[30]^prbs[31]}; 				  
   	end
	else prbs <= 32'h0000_0001;
end

//*********************************Main Body of Code**********************************

    assign tied_to_ground_vec_i  =   32'h00000000;
    assign tied_to_ground_i      =   1'b0;
    assign tied_to_vcc_i         =   1'b1;
    
//    //___________ synchronizing the async reset for ease of timing simulation ________
//    always@(posedge USER_CLK)
//        begin
//       system_reset_r <= `DLY SYSTEM_RESET;
//       system_reset_r2 <= `DLY system_reset_r;
//        end

    //____________________________ Counter to read from BRAM __________________________    

    always @(posedge CLK_40_BUFFERED)
//        if(system_reset_r2 || (read_counter_i == "111111111")) 
        if(read_counter_i == "111111111")   
        begin
             read_counter_i   <=  `DLY    9'd0;
        end
        else read_counter_i   <=  `DLY    read_counter_i + 9'd1;

    // Assign TX_DATA_OUT to BRAM output
//    always @(posedge CLK_40_BUFFERED)
//        if(system_reset_r2) TX_DATA_OUT <= `DLY 80'h0000000000; 
//        else             TX_DATA_OUT <= `DLY {tx_data_bram_i,tx_data_ram_r[15:0]}; 

always @(posedge CLK_40_BUFFERED)
    if (TRANSMIT_ON & TEST_BIT & !PRBS_BIT)
        TEST_DATA <= `DLY tx_data_ram_r[47:16];
    else if(TRANSMIT_ON & TEST_BIT & PRBS_BIT)
        TEST_DATA <= `DLY prbs;

    // Assign TXCTRL_OUT to BRAM output
    always @(posedge CLK_40_BUFFERED)
//        if(system_reset_r2) TXCTRL_OUT <= `DLY 8'h0; 
//        else             TXCTRL_OUT <= `DLY tx_ctrl_i; 
          if(TRANSMIT_ON & TEST_BIT) TXCTRL_OUT <= `DLY tx_ctrl_i;



    //________________________________ BRAM Inference Logic _____________________________    

//    assign tx_data_bram_i      = tx_data_ram_r[79:16];
    assign tx_ctrl_i           = tx_data_ram_r[15:8];
  
    initial
    begin
           $readmemh("gt_rom_init_tx.dat",rom,0,511);
    end

    always @(posedge CLK_40_BUFFERED)
           tx_data_ram_r <= `DLY rom[read_counter_i];
           
           
           


//assign TEST_DATA = PRBS_BIT ? prbs : rom_out_one;

//    rom_cg ROM_CG_INST (
    
//    .clka(CLK_40_BUFFERED),
//    .ena(rom_en),
//    .addra(temp),
//    .douta(rom_out_all));

//always @ (posedge CLK_40_BUFFERED)
//	begin
//		if (!rom_en) addr_counter = 9'b0_0000_0000;
//		else  addr_counter = addr_counter + 1'b1;
////		if (!rom_en) addr_counter = 9'b0_0000_0000;
////		else  addr_counter = addr_counter + 1'b1;
//	end

//always @ (ROM_SELECT,rom_out_all)
//	begin 
//		case (ROM_SELECT)
//			3'b000: rom_out_one = rom_out_all[31:0];
//			3'b001: rom_out_one = rom_out_all[63:32];
//			3'b010: rom_out_one = rom_out_all[95:64];
//			3'b011: rom_out_one = rom_out_all[127:96];
//			3'b100: rom_out_one = rom_out_all[159:128];
//			3'b101: rom_out_one = rom_out_all[191:160];
//			default:   rom_out_one = 32'h0000_0000;
//		endcase
//	end




endmodule
