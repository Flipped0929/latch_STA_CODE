cmake_minimum_required(VERSION 3.21)

foreach(required IN ITEMS INPUT OUTPUT TOP)
    if(NOT DEFINED ${required} OR "${${required}}" STREQUAL "")
        message(FATAL_ERROR "Specify -D${required}=...")
    endif()
endforeach()
if(NOT TOP MATCHES "^[A-Za-z_][A-Za-z_0-9]*$")
    message(FATAL_ERROR "TOP must be a simple Verilog module name")
endif()
if(NOT DEFINED YOSYS)
    find_program(YOSYS yosys REQUIRED)
endif()
if(NOT DEFINED PDK)
    set(PDK sky130)
endif()
if(NOT DEFINED PDK_DIR)
    set(PDK_DIR "${CMAKE_CURRENT_LIST_DIR}/../pdk")
endif()
set(abc_exclusions "")
if(PDK STREQUAL "sky130")
    if(NOT DEFINED LIBERTY)
        set(LIBERTY "${PDK_DIR}/sky130_pdk/sky130_fd_sc_hd__tt_025C_1v80.lib")
    endif()
    if(NOT DEFINED CELL_MAP)
        set(CELL_MAP "${PDK_DIR}/sky130_pdk/retimed_cell_map.v")
    endif()
    set(abc_exclusions "-dont_use sky130_fd_sc_hd__lpflow_* ")
endif()
foreach(source IN ITEMS INPUT LIBERTY CELL_MAP)
    if(NOT DEFINED ${source} OR "${${source}}" STREQUAL "")
        message(FATAL_ERROR "Specify -D${source}=... for PDK=${PDK}")
    endif()
    get_filename_component(${source} "${${source}}" ABSOLUTE)
    if(NOT EXISTS "${${source}}" OR IS_DIRECTORY "${${source}}")
        message(FATAL_ERROR "File not found: ${${source}}")
    endif()
endforeach()
if(EXISTS "${OUTPUT}" OR IS_SYMLINK "${OUTPUT}")
    message(FATAL_ERROR "Output already exists: ${OUTPUT}")
endif()

string(RANDOM LENGTH 16 ALPHABET 0123456789abcdef nonce)
set(staged "${OUTPUT}.mapping-${nonce}.tmp")
string(CONCAT script
    "hierarchy -check -top ${TOP}; check -assert; "
    "select -assert-any ${TOP}/t:$_DFF*; "
    "select -set clock_gates ${TOP}/w:clk_2 %co1:+$_AND_[A,B] ${TOP}/t:$_AND_ %i; "
    "read_liberty -lib -ignore_miss_func -ignore_miss_dir \"${LIBERTY}\"; "
    "techmap -map \"${CELL_MAP}\" ${TOP}/t:$_DFF* @clock_gates; "
    "select -assert-none t:$_DFF* t:$_SDFF* t:$_ALDFF* t:$_DLATCH* t:$_SR*; "
    "select -assert-none @clock_gates ${TOP}/t:$_AND_ %i; "
    "opt_merge ${TOP}/t:$_NOT_; "
    "abc -liberty \"${LIBERTY}\" ${abc_exclusions}${TOP}; "
    "clean; hierarchy -check -top ${TOP}; check -assert; "
    "select -assert-none t:$*; "
    "write_verilog -noattr -noexpr \"${staged}\""
)
execute_process(
    COMMAND "${YOSYS}" -Q -T -q -f "verilog -icells" "${INPUT}" -p "${script}"
    OUTPUT_QUIET
    RESULT_VARIABLE result
)
if(NOT result STREQUAL "0")
    file(REMOVE "${staged}")
    message(FATAL_ERROR "Mapping the netlist to ${PDK} failed: ${result}")
endif()
if(NOT EXISTS "${staged}")
    message(FATAL_ERROR "Yosys exited without writing the mapped netlist")
endif()

file(RENAME "${staged}" "${OUTPUT}" NO_REPLACE RESULT result)
if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux" AND
   NOT result STREQUAL "0" AND NOT result STREQUAL "NO_REPLACE")
    # CMake can require hard links here, which VMware shared folders reject.
    execute_process(
        COMMAND mv -nT -- "${staged}" "${OUTPUT}"
        RESULT_VARIABLE result
    )
    if(result STREQUAL "0" AND EXISTS "${staged}")
        set(result "NO_REPLACE")
    endif()
endif()
if(NOT result STREQUAL "0")
    file(REMOVE "${staged}")
    message(FATAL_ERROR "Publishing ${OUTPUT} failed: ${result}")
endif()
