# Group 5
# VCS Run file

tb_file="./FSM_V3/fsm_3_tb.sv"
design_file="./FSM_V3/fsm_3.v"
vcs $design_file -sverilog $tb_file -full64 -debug_all +v2k -kdb -l vcs.log -cm line+fsm+tgl+cond+branch
./simv -gui
./simv -cm line+tgl+cond+fsm
