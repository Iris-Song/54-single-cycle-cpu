######################################################################
#
# File name : cpu_tb_simulate.do
# Created on: Thu Jun 17 15:41:35 +0800 2021
#
# Auto generated by Vivado for 'post-synthesis' simulation
#
######################################################################
vsim -voptargs="+acc" +transport_int_delays +pulse_r/0 +pulse_int_r/0 -L simprims_ver -L secureip -L xil_defaultlib -lib xil_defaultlib xil_defaultlib.cpu_tb xil_defaultlib.glbl

do {cpu_tb_wave.do}

view wave
view structure
view signals

do {cpu_tb.udo}

run 1000ns