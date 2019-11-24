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
set_param synth.incrementalSynthesisCache E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/.Xil/Vivado-9648-GENGLONGFEI/incrSyn
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.cache/wt [current_project]
set_property parent.project_path E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo e:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files E:/vivado_workspace/20190930_test/WRA_NOCORE/filterdata.coe
add_files E:/vivado_workspace/20190930_test/WRA_NOCORE/Instruction.coe
add_files E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.sim/sim_1/behav/xsim/imagedata.coe
add_files E:/vivado_workspace/20190930_test/WRA_NOCORE/imagedata.coe
add_files E:/vivado_workspace/20190930_test/WRA_NOCORE/imagedata/imagedata.coe
add_files E:/vivado_workspace/ov5640_vga_vip_change/ila_data_gray1/word_dec/8-24/imagedata.coe
add_files E:/vivado_workspace/ov5640_vga_vip_change/ila_data_gray1/word_dec/8-25/imagedata.coe
read_verilog -library xil_defaultlib {
  E:/vivado_workspace/20190930_test/WRA_NOCORE/define.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/BtInB_Buffer.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/Buffer_Exchanger.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/Buffer_Grain_16_32_32bit.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/Channel_Accumu1_16.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/Channel_Accumulator.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/DMA_WRA.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/DSP16.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/DSP16_16.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/DSP16_lut.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/Decoder.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/FSM_Top.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/GFGt_Ram.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/Input_Buffer.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/Input_Trans.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/InstrMem.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/Output_Trans.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/ProgramCnt.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/Ram_Grain_32_32bit.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/ReadResult.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/Sign_Add.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/WRA_NOCORE.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/WRA_Top.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/WRA_ctl.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/new/i2c_dri.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/new/i2c_ov5640_rgb565_cfg.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/new/image_process_new.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/new/seg_display.v
  E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/new/top_identify.v
}
read_ip -quiet E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/blk_mem_gfgt_1/blk_mem_gfgt.xci
set_property used_in_implementation false [get_files -all e:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/blk_mem_gfgt_1/blk_mem_gfgt_ooc.xdc]

read_ip -quiet E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/block_ram1/block_ram1.xci
set_property used_in_implementation false [get_files -all e:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/block_ram1/block_ram1_ooc.xdc]

read_ip -quiet E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1.xci
set_property used_in_implementation false [get_files -all e:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1_board.xdc]
set_property used_in_implementation false [get_files -all e:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1.xdc]
set_property used_in_implementation false [get_files -all e:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1_ooc.xdc]

read_ip -quiet E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/blk_mem/blk_mem.xci
set_property used_in_implementation false [get_files -all e:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/blk_mem/blk_mem_ooc.xdc]

read_ip -quiet E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/mult/mult.xci
set_property used_in_implementation false [get_files -all e:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/mult/mult_ooc.xdc]

read_ip -quiet E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/instrmemory/instrmemory.xci
set_property used_in_implementation false [get_files -all e:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/instrmemory/instrmemory_ooc.xdc]

read_ip -quiet E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/DataFIFO/DataFIFO.xci
set_property used_in_implementation false [get_files -all e:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/DataFIFO/DataFIFO.xdc]
set_property used_in_implementation false [get_files -all e:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/DataFIFO/DataFIFO_ooc.xdc]

read_ip -quiet E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/FilterRam/FilterRam.xci
set_property used_in_implementation false [get_files -all e:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/FilterRam/FilterRam_ooc.xdc]

read_ip -quiet E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/mult_lut/mult_lut.xci
set_property used_in_implementation false [get_files -all e:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/sources_1/ip/mult_lut/mult_lut_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/constrs_1/new/xdc.xdc
set_property used_in_implementation false [get_files E:/vivado_workspace/20190930_test/WRA_NOCORE/V3/V3.srcs/constrs_1/new/xdc.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top top -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
