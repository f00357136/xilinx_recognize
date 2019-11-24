onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib block_ram1_opt

do {wave.do}

view wave
view structure
view signals

do {block_ram1.udo}

run -all

quit -force