onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib FilterRam_opt

do {wave.do}

view wave
view structure
view signals

do {FilterRam.udo}

run -all

quit -force
