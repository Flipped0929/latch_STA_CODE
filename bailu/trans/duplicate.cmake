cmake_minimum_required(VERSION 3.21)

foreach(required IN ITEMS INPUT OUTPUT TOP DUPLICATE)
    if(NOT DEFINED ${required} OR "${${required}}" STREQUAL "")
        message(FATAL_ERROR "Specify -D${required}=...")
    endif()
endforeach()
if(NOT TOP MATCHES "^[A-Za-z_][A-Za-z_0-9]*$")
    message(FATAL_ERROR "TOP must be a simple Verilog module name")
endif()
if(NOT DEFINED CLOCK)
    set(CLOCK clk)
endif()
if(NOT DEFINED YOSYS)
    find_program(YOSYS yosys)
    if(NOT YOSYS)
        message(FATAL_ERROR "Set -DYOSYS=... to the Yosys executable")
    endif()
endif()
set(outputs OUTPUT)
if(DEFINED GATED_OUTPUT)
    if(GATED_OUTPUT STREQUAL "")
        message(FATAL_ERROR "Specify -DGATED_OUTPUT=...")
    endif()
    get_filename_component(duplicate_path "${OUTPUT}" ABSOLUTE)
    get_filename_component(gated_path "${GATED_OUTPUT}" ABSOLUTE)
    if(duplicate_path STREQUAL gated_path)
        message(FATAL_ERROR "OUTPUT and GATED_OUTPUT must be different files")
    endif()
    list(APPEND outputs GATED_OUTPUT)
endif()
foreach(kind IN LISTS outputs)
    if(EXISTS "${${kind}}" OR IS_SYMLINK "${${kind}}")
        message(FATAL_ERROR "Output already exists: ${${kind}}")
    endif()
endforeach()

string(RANDOM LENGTH 16 ALPHABET 0123456789abcdef nonce)
set(source_json "duplicate-${nonce}-input.json")
set(intermediate "duplicate-${nonce}.json")
execute_process(
    COMMAND "${YOSYS}" -Q -T -q -f "verilog -icells" "${INPUT}"
        -p "hierarchy -check -top ${TOP}; check -assert; write_json"
    OUTPUT_FILE "${source_json}"
    RESULT_VARIABLE result
)
if(NOT result STREQUAL "0")
    file(REMOVE "${source_json}")
    message(FATAL_ERROR "Reading the source netlist failed: ${result}")
endif()

foreach(kind IN LISTS outputs)
    set(mode)
    if(kind STREQUAL "GATED_OUTPUT")
        set(mode --clock-gate)
    endif()
    execute_process(
        COMMAND "${DUPLICATE}" "${TOP}" "${CLOCK}" ${mode}
        INPUT_FILE "${source_json}"
        OUTPUT_FILE "${intermediate}"
        RESULT_VARIABLE result
    )
    if(NOT result STREQUAL "0")
        file(REMOVE "${source_json}" "${intermediate}")
        message(FATAL_ERROR "Converting the netlist for ${kind} failed: ${result}")
    endif()
    execute_process(
        COMMAND "${YOSYS}" -Q -T -q -f json "${intermediate}"
            -p "hierarchy -check -top ${TOP}; check -assert; write_verilog -noattr -noexpr"
        OUTPUT_VARIABLE verilog_${kind}
        RESULT_VARIABLE result
    )
    file(REMOVE "${intermediate}")
    if(NOT result STREQUAL "0")
        file(REMOVE "${source_json}")
        message(FATAL_ERROR "Checking or writing the netlist for ${kind} failed: ${result}")
    endif()
endforeach()
file(REMOVE "${source_json}")

foreach(kind IN LISTS outputs)
    set(staged "${${kind}}.duplicate-${nonce}.tmp")
    file(WRITE "${staged}" "${verilog_${kind}}")
    file(RENAME "${staged}" "${${kind}}" NO_REPLACE RESULT result)

    if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux" AND
    NOT result STREQUAL "0" AND NOT result STREQUAL "NO_REPLACE")
        execute_process(
            COMMAND mv -nT -- "${staged}" "${${kind}}"
            RESULT_VARIABLE result
        )
        if(result STREQUAL "0" AND EXISTS "${staged}")
            set(result "NO_REPLACE")
        endif()
    endif()

    if(NOT result STREQUAL "0")
        file(REMOVE "${staged}")
        message(FATAL_ERROR "Publishing ${${kind}} failed: ${result}")
    endif()
endforeach()
