PICORV32_DFF_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

export DESIGN_NAME = picorv32
export DESIGN_NICKNAME = picorv32_dff
export PLATFORM = sky130hd

# Synthesize the RTL with its default parameters, including the register file.
export VERILOG_FILES = $(PICORV32_DFF_DIR)/picorv32.v
export SDC_FILE = $(PICORV32_DFF_DIR)/picorv32.sdc

# ABC uses ps: keep this equal to the 10 ns clock in picorv32.sdc.
export ABC_CLOCK_PERIOD_IN_PS = 10000

# Initial floorplan settings for the subsequent RTL-to-GDS stages.
export CORE_UTILIZATION = 35
export CORE_ASPECT_RATIO = 1
export CORE_MARGIN = 10
export PLACE_DENSITY = 0.60
