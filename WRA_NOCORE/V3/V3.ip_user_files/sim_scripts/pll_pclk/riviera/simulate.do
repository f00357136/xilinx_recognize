onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+pll_pclk -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.pll_pclk xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {pll_pclk.udo}

run -all

endsim

quit -force
