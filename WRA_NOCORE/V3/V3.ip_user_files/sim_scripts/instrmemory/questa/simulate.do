onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib instrmemory_opt

do {wave.do}

view wave
view structure
view signals

do {instrmemory.udo}

run -all

quit -force
