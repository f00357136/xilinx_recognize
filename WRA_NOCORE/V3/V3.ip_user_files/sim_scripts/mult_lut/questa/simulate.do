onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib mult_lut_opt

do {wave.do}

view wave
view structure
view signals

do {mult_lut.udo}

run -all

quit -force
