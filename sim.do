set name top_tb
set path Encoder

vlib work
 vlog "../$path/enc.sv" 
 vlog "../$path/$name.sv" 
 
 
vsim -voptargs=+acc work.$name 
# Set the window types 
view wave do
view structure
view signals
#add wave 
add wave -noupdate -divider {all}
add wave -noupdate -binary sim:/$name/* 
add wave -noupdate -divider {dut}
add wave -noupdate -binary sim:/$name/dut/* 
run -all
 