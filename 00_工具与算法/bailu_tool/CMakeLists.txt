cmake_minimum_required(VERSION 3.10)

# All third-party dependencies are installed in the conda environment.
if(DEFINED ENV{CONDA_PREFIX})
    set(CMAKE_PREFIX_PATH "$ENV{CONDA_PREFIX}")
endif()

# LEDA library location (LEDA 7.2.3).  An explicit -DLEDA_ROOT takes
# precedence; otherwise initialise it from the conventional LEDAROOT
# environment variable.  Do not unconditionally cache $ENV{LEDAROOT}: an
# empty value from the first configure would then hide a value exported before
# a later configure of the same build directory.
set(LEDA_ROOT "" CACHE PATH "LEDA installation directory")
if(NOT LEDA_ROOT AND DEFINED ENV{LEDAROOT} AND NOT "$ENV{LEDAROOT}" STREQUAL "")
    set(LEDA_ROOT "$ENV{LEDAROOT}" CACHE PATH
        "LEDA installation directory" FORCE)
endif()

project(EllCpp LANGUAGES CXX)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# LEDA 7.x headers (must come before the project include dir so they shadow
# the vendored LEDA 6.3 headers in include/LEDA).  LEDA's archive is commonly
# installed directly in LEDA_ROOT rather than in LEDA_ROOT/lib.
set(_LEDA_HINTS)
if(LEDA_ROOT)
    list(APPEND _LEDA_HINTS "${LEDA_ROOT}")
endif()

find_library(LEDA_LIB NAMES leda
    HINTS ${_LEDA_HINTS}
    PATH_SUFFIXES lib lib64)

# If an earlier configure (or -DLEDA_LIB=...) already located the library,
# also inspect its directory for the sibling incl/ directory.
if(LEDA_LIB)
    get_filename_component(_LEDA_LIBRARY_DIR "${LEDA_LIB}" DIRECTORY)
    get_filename_component(_LEDA_LIBRARY_PARENT "${_LEDA_LIBRARY_DIR}" DIRECTORY)
    list(APPEND _LEDA_HINTS "${_LEDA_LIBRARY_DIR}" "${_LEDA_LIBRARY_PARENT}")
endif()

find_path(LEDA_INCLUDE_DIR LEDA/core/p_queue.h
    HINTS ${_LEDA_HINTS}
    PATH_SUFFIXES incl include)

if(NOT LEDA_INCLUDE_DIR OR NOT LEDA_LIB)
    message(FATAL_ERROR
        "LEDA headers or library not found. Set LEDAROOT to the LEDA "
        "installation directory, or configure with "
        "-DLEDA_ROOT=<installation directory>.")
endif()
include_directories("${LEDA_INCLUDE_DIR}")

# Project headers plus conda-provided third-party headers.
include_directories("${CMAKE_CURRENT_LIST_DIR}/include")
if(DEFINED ENV{CONDA_PREFIX})
    include_directories("$ENV{CONDA_PREFIX}/include")
endif()

find_package(Threads REQUIRED)

# GLPK (used by src/LP.cpp for linear-programming based MCR/ELL)
find_library(GLPK_LIB NAMES glpk REQUIRED)

# OpenBLAS provides BLAS/CBLAS/LAPACK symbols used through xtensor-blas
find_library(OPENBLAS_LIB NAMES openblas REQUIRED)

# Fortran runtime (required by OpenBLAS / LAPACK)
find_library(GFORTRAN_LIB NAMES gfortran REQUIRED)

# libm
find_library(M_LIB NAMES m REQUIRED)

aux_source_directory(src SRC_LIST)
add_executable(main ${SRC_LIST})

target_link_libraries(main
    Threads::Threads
    ${LEDA_LIB}
    ${GLPK_LIB}
    ${OPENBLAS_LIB}
    ${GFORTRAN_LIB}
    ${M_LIB})
