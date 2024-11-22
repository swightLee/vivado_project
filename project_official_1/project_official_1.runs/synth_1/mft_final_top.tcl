# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param tcl.collectionResultDisplayLimit 0
set_param chipscope.maxJobs 4
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7k70tfbg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.cache/wt [current_project]
set_property parent.project_path C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/tx.coe
read_mem {
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/imports/example_design/gt_rom_init_rx.dat
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/imports/example_design/gt_rom_init_tx.dat
}
read_verilog -library xil_defaultlib {
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/new/IBUFDS32_LVDS_25_DT.v
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/new/IBUFDS_LVDS_25_DT.v
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/new/IBUFDS_LVDS_25_DT_INV.v
  {C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/new/clk_40_ buf.v}
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/new/control_and_state.v
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/new/fifo_instantiation.v
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/imports/example_design/support/gtwizard_0_common.v
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/imports/example_design/support/gtwizard_0_common_reset.v
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/imports/example_design/gtwizard_0_exdes.v
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/imports/example_design/support/gtwizard_0_gt_usrclk_source.v
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/imports/example_design/support/gtwizard_0_support.v
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/new/hits_buffer_stretch.v
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/new/k_inserter.v
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/new/stretcher.v
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/new/stretcher_32b.v
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/new/test_data_generator.v
  C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/new/mft_final_top.v
}
read_ip -quiet C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/ip/gtwizard_0/gtwizard_0.xci
set_property used_in_implementation false [get_files -all c:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/ip/gtwizard_0/gtwizard_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/ip/gtwizard_0/gtwizard_0_ooc.xdc]

read_ip -quiet C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/ip/vio_0/vio_0.xci
set_property used_in_implementation false [get_files -all c:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/ip/vio_0/vio_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/ip/vio_0/vio_0_ooc.xdc]

read_ip -quiet C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/ip/clk_buf_40/clk_buf_40.xci
set_property used_in_implementation false [get_files -all c:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/ip/clk_buf_40/clk_buf_40_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/ip/clk_buf_40/clk_buf_40.xdc]
set_property used_in_implementation false [get_files -all c:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/ip/clk_buf_40/clk_buf_40_ooc.xdc]

read_ip -quiet C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/ip/fifo_cg/fifo_cg.xci
set_property used_in_implementation false [get_files -all c:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/ip/fifo_cg/fifo_cg.xdc]
set_property used_in_implementation false [get_files -all c:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/ip/fifo_cg/fifo_cg_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/ip/fifo_cg/fifo_cg_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/constrs_1/new/conb.xdc
set_property used_in_implementation false [get_files C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/constrs_1/new/conb.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top mft_final_top -part xc7k70tfbg484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef mft_final_top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file mft_final_top_utilization_synth.rpt -pb mft_final_top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]