# Group 5
# Formal verification

clear -all
set ROOT_PATH ./
set RTL_PATH ${ROOT_PATH}/FSM_V3
set PROP_PATH ${ROOT_PATH}/properties

# Analyzing the design and property files

analyze -verilog ${RTL_PATH}/fsm_3.v
analyze -sva ${PROP_PATH}/binding.sva 
analyze -sva ${PROP_PATH}/FSM_properties.sva

# Elaborate the design
elaborate -verilog -top {fsm_3}

# Set up clk and rst
clock clk
reset -none -non_resettable_regs 1
get_design_info
set_max_trace_length 10

prove -all

