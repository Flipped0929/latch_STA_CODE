# Run with the project xschemrc and counter_routed.sch loaded.
set root [file normalize [file join [file dirname [info script]] ../..]]
set netlist_dir [file join $root simulation]
set local_netlist_dir 0
set netlist_type verilog
set verilog_2001 1
set show_infowindow 0
set dark_colorscheme 0
set color_ps 1
set svg_font_name {DejaVu Sans}
set transparent_svg 0
set netlist_show 0
xschem netlist -noalert
xschem line_width 1.3
xschem print svg [file join $root counter_routed.svg] 4200 3300 0 0 3440 2700
puts "POST_ROUTE_SCHEMATIC_EXPORTED"
exit
