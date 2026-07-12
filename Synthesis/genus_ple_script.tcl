set_db init_lib_search_path ./lib/timing
set_db init_hdl_search_path ./RTL

read_libs {fast_vdd1v0_basicCells_hvt.lib  slow_vdd1v0_basicCells_hvt.lib fast_vdd1v0_basicCells.lib      slow_vdd1v0_basicCells.lib fast_vdd1v0_basicCells_lvt.lib  slow_vdd1v0_basicCells_lvt.lib}

read_physical -lef {./lib/lef/gsclib045_hvt_macro.lef ./lib/lef/gsclib045_macro.lef ./lib/lef/gsclib045_tech.lef ./lib/lef/gsclib045_lvt_macro.lef}

read_hdl "alu.v control_unit.v decoder.v program_counter.v regfile.v riscv_top.v"

elaborate riscv_top

read_mmmc ./mmmc.tcl

init_design

check_design -unresolved

report_ple

set_db invs_temp_dir invs_temp_dir

set_db predict_floorplan_enable_during_generic true

set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium

syn_generic -physical
syn_map -physical
#syn_opt -physical

#reports
report_timing > ./report_timing_ple.rpt
report_power  > ./report_power_ple.rpt
report_area   > ./report_area_ple.rpt
report_qor    > ./report_qor_ple.rpt
report_clock_gating	> ./report_clock_gating_ple.rpt


#Outputs
write_hdl > ./riscv_netlist_ple.v
write_sdc > ./riscv_sdc_ple.sdc





