-makelib ies_lib/xil_defaultlib -sv \
  "E:/vivado/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "E:/vivado/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "E:/vivado/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../project_official_1.srcs/sources_1/ip/clk_buf_40/clk_buf_40_clk_wiz.v" \
  "../../../../project_official_1.srcs/sources_1/ip/clk_buf_40/clk_buf_40.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

