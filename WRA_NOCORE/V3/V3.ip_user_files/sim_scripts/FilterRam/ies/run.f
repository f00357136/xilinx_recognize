-makelib ies_lib/xil_defaultlib -sv \
  "C:/Andrew/Software/vivado2018/Vivado/2018.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "C:/Andrew/Software/vivado2018/Vivado/2018.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "C:/Andrew/Software/vivado2018/Vivado/2018.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/dist_mem_gen_v8_0_12 \
  "../../../ipstatic/simulation/dist_mem_gen_v8_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../V3.srcs/sources_1/ip/FilterRam/sim/FilterRam.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

