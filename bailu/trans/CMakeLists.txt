cmake_minimum_required(VERSION 3.15)
project(LatchSTATrans LANGUAGES CXX)

find_package(nlohmann_json 3.7 CONFIG REQUIRED)
add_executable(duplicate duplicate.cpp clock_gate.cpp)
target_compile_features(duplicate PRIVATE cxx_std_17)
target_link_libraries(duplicate PRIVATE nlohmann_json::nlohmann_json)
