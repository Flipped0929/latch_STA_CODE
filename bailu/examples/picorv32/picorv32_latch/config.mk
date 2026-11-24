PICORV32_LATCH_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

export DESIGN_NAME = picorv32
export DESIGN_NICKNAME = picorv32_latch
export PLATFORM = sky130hd

export SYNTH_NETLIST_FILES = $(PICORV32_LATCH_DIR)/picorv32_sky130.v
export SDC_FILE = $(PICORV32_LATCH_DIR)/picorv32.sdc
export PRE_FLOORPLAN_TCL = $(PICORV32_LATCH_DIR)/fix_cons.tcl

export CORE_UTILIZATION = 35
export CORE_ASPECT_RATIO = 1
export CORE_MARGIN = 10
export PLACE_DENSITY = 0.60

# Reapply clock-gating checks after loading each stage's SDC.
export PRE_GLOBAL_PLACE_SKIP_IO_TCL = $(PICORV32_LATCH_DIR)/gating_checks.tcl
export PRE_GLOBAL_PLACE_TCL = $(PICORV32_LATCH_DIR)/gating_checks.tcl
export PRE_RESIZE_TCL = $(PICORV32_LATCH_DIR)/gating_checks.tcl
export PRE_DETAIL_PLACE_TCL = $(PICORV32_LATCH_DIR)/gating_checks.tcl
export PRE_CTS_TCL = $(PICORV32_LATCH_DIR)/gating_checks.tcl
export PRE_GLOBAL_ROUTE_TCL = $(PICORV32_LATCH_DIR)/gating_checks.tcl
export PRE_DETAIL_ROUTE_TCL = $(PICORV32_LATCH_DIR)/gating_checks.tcl
export PRE_FINAL_REPORT_TCL = $(PICORV32_LATCH_DIR)/gating_checks.tcl

# Target an additional 30 ps of hold slack during repair.
export HOLD_SLACK_MARGIN = 0.03
