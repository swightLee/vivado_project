create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 3 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list inst_gt/gtwizard_0_support_i/gt_usrclk_source/gt0_rxusrclk2_out]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {inst_gt/gt0_rxdata_i[0]} {inst_gt/gt0_rxdata_i[1]} {inst_gt/gt0_rxdata_i[2]} {inst_gt/gt0_rxdata_i[3]} {inst_gt/gt0_rxdata_i[4]} {inst_gt/gt0_rxdata_i[5]} {inst_gt/gt0_rxdata_i[6]} {inst_gt/gt0_rxdata_i[7]} {inst_gt/gt0_rxdata_i[8]} {inst_gt/gt0_rxdata_i[9]} {inst_gt/gt0_rxdata_i[10]} {inst_gt/gt0_rxdata_i[11]} {inst_gt/gt0_rxdata_i[12]} {inst_gt/gt0_rxdata_i[13]} {inst_gt/gt0_rxdata_i[14]} {inst_gt/gt0_rxdata_i[15]} {inst_gt/gt0_rxdata_i[16]} {inst_gt/gt0_rxdata_i[17]} {inst_gt/gt0_rxdata_i[18]} {inst_gt/gt0_rxdata_i[19]} {inst_gt/gt0_rxdata_i[20]} {inst_gt/gt0_rxdata_i[21]} {inst_gt/gt0_rxdata_i[22]} {inst_gt/gt0_rxdata_i[23]} {inst_gt/gt0_rxdata_i[24]} {inst_gt/gt0_rxdata_i[25]} {inst_gt/gt0_rxdata_i[26]} {inst_gt/gt0_rxdata_i[27]} {inst_gt/gt0_rxdata_i[28]} {inst_gt/gt0_rxdata_i[29]} {inst_gt/gt0_rxdata_i[30]} {inst_gt/gt0_rxdata_i[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 4 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {inst_gt/gt0_rxcharisk_i[0]} {inst_gt/gt0_rxcharisk_i[1]} {inst_gt/gt0_rxcharisk_i[2]} {inst_gt/gt0_rxcharisk_i[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 4 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {inst_gt/TXCTRL_IN[0]} {inst_gt/TXCTRL_IN[1]} {inst_gt/TXCTRL_IN[2]} {inst_gt/TXCTRL_IN[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {inst_gt/DATA_FIFO_OUT_GT_IN[0]} {inst_gt/DATA_FIFO_OUT_GT_IN[1]} {inst_gt/DATA_FIFO_OUT_GT_IN[2]} {inst_gt/DATA_FIFO_OUT_GT_IN[3]} {inst_gt/DATA_FIFO_OUT_GT_IN[4]} {inst_gt/DATA_FIFO_OUT_GT_IN[5]} {inst_gt/DATA_FIFO_OUT_GT_IN[6]} {inst_gt/DATA_FIFO_OUT_GT_IN[7]} {inst_gt/DATA_FIFO_OUT_GT_IN[8]} {inst_gt/DATA_FIFO_OUT_GT_IN[9]} {inst_gt/DATA_FIFO_OUT_GT_IN[10]} {inst_gt/DATA_FIFO_OUT_GT_IN[11]} {inst_gt/DATA_FIFO_OUT_GT_IN[12]} {inst_gt/DATA_FIFO_OUT_GT_IN[13]} {inst_gt/DATA_FIFO_OUT_GT_IN[14]} {inst_gt/DATA_FIFO_OUT_GT_IN[15]} {inst_gt/DATA_FIFO_OUT_GT_IN[16]} {inst_gt/DATA_FIFO_OUT_GT_IN[17]} {inst_gt/DATA_FIFO_OUT_GT_IN[18]} {inst_gt/DATA_FIFO_OUT_GT_IN[19]} {inst_gt/DATA_FIFO_OUT_GT_IN[20]} {inst_gt/DATA_FIFO_OUT_GT_IN[21]} {inst_gt/DATA_FIFO_OUT_GT_IN[22]} {inst_gt/DATA_FIFO_OUT_GT_IN[23]} {inst_gt/DATA_FIFO_OUT_GT_IN[24]} {inst_gt/DATA_FIFO_OUT_GT_IN[25]} {inst_gt/DATA_FIFO_OUT_GT_IN[26]} {inst_gt/DATA_FIFO_OUT_GT_IN[27]} {inst_gt/DATA_FIFO_OUT_GT_IN[28]} {inst_gt/DATA_FIFO_OUT_GT_IN[29]} {inst_gt/DATA_FIFO_OUT_GT_IN[30]} {inst_gt/DATA_FIFO_OUT_GT_IN[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 4 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {data_or_k[0]} {data_or_k[1]} {data_or_k[2]} {data_or_k[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 32 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {data_to_mgt[0]} {data_to_mgt[1]} {data_to_mgt[2]} {data_to_mgt[3]} {data_to_mgt[4]} {data_to_mgt[5]} {data_to_mgt[6]} {data_to_mgt[7]} {data_to_mgt[8]} {data_to_mgt[9]} {data_to_mgt[10]} {data_to_mgt[11]} {data_to_mgt[12]} {data_to_mgt[13]} {data_to_mgt[14]} {data_to_mgt[15]} {data_to_mgt[16]} {data_to_mgt[17]} {data_to_mgt[18]} {data_to_mgt[19]} {data_to_mgt[20]} {data_to_mgt[21]} {data_to_mgt[22]} {data_to_mgt[23]} {data_to_mgt[24]} {data_to_mgt[25]} {data_to_mgt[26]} {data_to_mgt[27]} {data_to_mgt[28]} {data_to_mgt[29]} {data_to_mgt[30]} {data_to_mgt[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list INST_K_INSERTER/connecting]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_125_buf]


create_clock -period 11.429 [get_ports refclk_875_p]
create_clock -period 8.0 [get_ports sysclk_p]

# User Clock Constraints


set_false_path -to [get_pins -filter {REF_PIN_NAME=~*CLR} -of_objects [get_cells -hierarchical -filter {NAME =~ *_txfsmresetdone_r*}]]
set_false_path -to [get_pins -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *_txfsmresetdone_r*}]]
set_false_path -to [get_pins -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_on_error_in_r*}]]
################################# RefClk Location constraints #####################

set_property LOC F5 [get_ports  refclk_875_n ] 
set_property LOC F6 [get_ports  refclk_875_p ]

 
################################# mgt wrapper constraints #####################

##---------- Set placement for gt0_gtx_wrapper_i/GTXE2_CHANNEL ------
set_property LOC GTXE2_CHANNEL_X0Y0 [get_cells GT_CUSTOM_support_i/GT_CUSTOM_init_i/inst/GT_CUSTOM_i/gt0_GT_CUSTOM_i/gtxe2_i]


#pin_tim
set_property PACKAGE_PIN N22 [get_ports {DATA[0]}]
set_property PACKAGE_PIN M21 [get_ports {DATA[1]}]
set_property PACKAGE_PIN M22 [get_ports {DATA[2]}]
set_property PACKAGE_PIN L21 [get_ports {DATA[3]}]
set_property PACKAGE_PIN K22 [get_ports {DATA[4]}]
set_property PACKAGE_PIN K21 [get_ports {DATA[5]}]
set_property PACKAGE_PIN N18 [get_ports {DATA[6]}]
set_property PACKAGE_PIN M17 [get_ports {DATA[7]}]
set_property PACKAGE_PIN G21 [get_ports {DATA[8]}]
set_property PACKAGE_PIN F21 [get_ports {DATA[9]}]
set_property PACKAGE_PIN J22 [get_ports {DATA[10]}]
set_property PACKAGE_PIN J21 [get_ports {DATA[11]}]
set_property PACKAGE_PIN H22 [get_ports {DATA[12]}]
set_property PACKAGE_PIN G22 [get_ports {DATA[13]}]
set_property PACKAGE_PIN E22 [get_ports {DATA[14]}]
set_property PACKAGE_PIN E21 [get_ports {DATA[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DATA[0]}]

set_property IOSTANDARD LVDS_25 [get_ports {HIT[31]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[30]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[29]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[28]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[27]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[26]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[25]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[24]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[23]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[22]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[21]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[20]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[19]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[18]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[17]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[16]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[15]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[14]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[13]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[12]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[11]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[10]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[9]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[8]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {HIT[0]}]

set_property IOSTANDARD LVDS_25 [get_ports {HITB[31]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[30]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[29]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[28]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[27]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[26]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[25]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[24]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[23]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[22]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[21]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[20]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[19]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[18]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[17]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[16]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[15]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[14]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[13]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[12]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[11]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[10]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[9]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[8]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {HITB[0]}]


set_property PACKAGE_PIN T16 [get_ports {HIT[31]}]
set_property PACKAGE_PIN B13 [get_ports {HIT[30]}]
set_property PACKAGE_PIN Y17 [get_ports {HIT[29]}]
set_property PACKAGE_PIN Y16 [get_ports {HIT[28]}]
set_property PACKAGE_PIN V15 [get_ports {HIT[27]}]
set_property PACKAGE_PIN U16 [get_ports {HIT[26]}]
set_property PACKAGE_PIN U18 [get_ports {HIT[25]}]
set_property PACKAGE_PIN U17 [get_ports {HIT[24]}]
set_property PACKAGE_PIN C12 [get_ports {HIT[23]}]
set_property PACKAGE_PIN A13 [get_ports {HIT[22]}]
set_property PACKAGE_PIN B16 [get_ports {HIT[21]}]
set_property PACKAGE_PIN B18 [get_ports {HIT[20]}]
set_property PACKAGE_PIN C14 [get_ports {HIT[19]}]
set_property PACKAGE_PIN F15 [get_ports {HIT[18]}]
set_property PACKAGE_PIN G15 [get_ports {HIT[17]}]
set_property PACKAGE_PIN F18 [get_ports {HIT[16]}]
set_property PACKAGE_PIN T20 [get_ports {HIT[15]}]
set_property PACKAGE_PIN V19 [get_ports {HIT[14]}]
set_property PACKAGE_PIN V20 [get_ports {HIT[13]}]
set_property PACKAGE_PIN T21 [get_ports {HIT[12]}]
set_property PACKAGE_PIN U22 [get_ports {HIT[11]}]
set_property PACKAGE_PIN W21 [get_ports {HIT[10]}]
set_property PACKAGE_PIN Y21 [get_ports {HIT[9]}]
set_property PACKAGE_PIN AA21 [get_ports {HIT[8]}]
set_property PACKAGE_PIN Y18 [get_ports {HIT[7]}]
set_property PACKAGE_PIN AA20 [get_ports {HIT[6]}]
set_property PACKAGE_PIN AA19 [get_ports {HIT[5]}]
set_property PACKAGE_PIN AA18 [get_ports {HIT[4]}]
set_property PACKAGE_PIN AA16 [get_ports {HIT[3]}]
set_property PACKAGE_PIN AB15 [get_ports {HIT[2]}]
set_property PACKAGE_PIN AA14 [get_ports {HIT[1]}]
set_property PACKAGE_PIN W14 [get_ports {HIT[0]}]

set_property PACKAGE_PIN H12 [get_ports ERR_LED]
set_property IOSTANDARD LVCMOS25 [get_ports ERR_LED]

set_property PACKAGE_PIN R22 [get_ports MYDIR]
set_property IOSTANDARD LVCMOS33 [get_ports MYDIR]

set_property PACKAGE_PIN P22 [get_ports MYEN]
set_property IOSTANDARD LVCMOS33 [get_ports MYEN]

set_property IOSTANDARD LVCMOS33 [get_ports FRST]
set_property PACKAGE_PIN N20 [get_ports FRST]

set_property IOSTANDARD LVCMOS18 [get_ports out_hit0]
set_property PACKAGE_PIN AA1 [get_ports out_hit0]

set_property IOSTANDARD LVCMOS25 [get_ports RUN_LED]
set_property PACKAGE_PIN G10 [get_ports RUN_LED]

set_property PACKAGE_PIN E14 [get_ports sysclk_p]
set_property IOSTANDARD LVDS_25 [get_ports sysclk_p]
set_property PACKAGE_PIN D14 [get_ports sysclk_n]
set_property IOSTANDARD LVDS_25 [get_ports sysclk_n]

set_property PACKAGE_PIN G3 [get_ports RXN]
#set_property IOSTANDARD LVDS_25 [get_ports RXN]
set_property PACKAGE_PIN G4 [get_ports RXP]
#set_property IOSTANDARD LVDS_25 [get_ports RXP]
set_property PACKAGE_PIN F1 [get_ports TXN]
#set_property IOSTANDARD LVDS_25 [get_ports TXN]
set_property PACKAGE_PIN F2 [get_ports TXP]
#set_property IOSTANDARD LVDS_25 [get_ports TXP]

set_property PACKAGE_PIN M18 [get_ports RDCTRL]
set_property IOSTANDARD LVCMOS33 [get_ports RDCTRL]

set_property PACKAGE_PIN N19 [get_ports WRCTRL]
set_property IOSTANDARD LVCMOS33 [get_ports WRCTRL]

set_property PACKAGE_PIN J20 [get_ports ACK]
set_property IOSTANDARD LVCMOS33 [get_ports ACK]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets INST_HITS_BUF_STRETCHER/HITS_BUFFER_INST/inst00/out_hit0_OBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets INST_CLK_BUF/instance_name/inst/clk_in1_clk_buf_40]

#set_property PACKAGE_PIN AA1 [get_ports test_ports_0]
##n:ab1
#set_property IOSTANDARD LVCMOS18 [get_ports test_ports_0]

#set_property PACKAGE_PIN AA3 [get_ports test_ports_1]
##n:ab2  
#set_property IOSTANDARD LVCMOS18 [get_ports test_ports_1]

#set_property PACKAGE_PIN AA4 [get_ports test_ports_2]
##n:ab3
#set_property IOSTANDARD LVCMOS18 [get_ports test_ports_2]

#set_property PACKAGE_PIN Y3 [get_ports test_ports_3]
##n:y2
#set_property IOSTANDARD LVCMOS18 [get_ports test_ports_3]

#set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets INST_CLK_BUF/clk_in]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_in]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets test_ports_0_OBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_125_in]