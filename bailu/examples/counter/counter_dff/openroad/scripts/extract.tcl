source [file join [file dirname [info script]] common.tcl]
guarded {
    load_technology
    # Import a clean DEF so no placement/global-route RC estimates survive.
    read_def $results/counter_routed.def
    if {![design_is_routed -verbose]} {error "Input DEF has unrouted nets"}
    define_process_corner -ext_model_index 0 typical
    extract_parasitics -ext_model_file $platform/rcx_patterns.rules -coupling_threshold 0.1
    write_spef $results/counter.spef
    write_db $results/counter_extracted.odb
    puts "EXTRACTION_COMPLETE"
}
