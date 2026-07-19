read library ./lib/verilog/slow_vdd1v0_basicCells.v ./lib/verilog/slow_vdd1v0_basicCells_lvt.v ./lib/verilog/slow_vdd1v0_basicCells_hvt.v -verilog -both

read design -verilog   -golden -lastmod -noelab fv/riscv_top/fv_map.v.gz
elaborate design -golden -root riscv_top

read design -verilog -revised -lastmod -noelab riscv_netlist.v 
elaborate design -revised -root riscv_top


set flatten model -seq_constant
set flatten model -seq_constant_x_to 0
set flatten model -nodff_to_dlat_zero
set flatten model -nodff_to_dlat_feedback
set flatten model -hier_seq_merge
set flatten model -gated_clock

set system mode lec
report unmapped points -summary
report unmapped points -notmapped


add compared point -all
compare 

report compare data -class nonequivalent -class abort -class notcompared
report verification -verbose
