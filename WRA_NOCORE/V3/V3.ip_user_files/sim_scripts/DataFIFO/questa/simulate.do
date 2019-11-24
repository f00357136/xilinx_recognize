onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib DataFIFO_opt

do {wave.do}

view wave
view structure
view signals

do {DataFIFO.udo}

run -all

quit -force
