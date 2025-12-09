# cmake project definition
cmake_minimum_required(VERSION 3.24.0)
cmake_policy(VERSION 3.24)

# default build kit is prod (when not specified as command line argument)
set(BUILD_KIT prod CACHE STRING "Target Group to build.")

# Variant selection (default to Windows so running plain CMake targets Windows)
set(VARIANT "Windows" CACHE STRING "Variant to build (e.g. Windows, Linux)")

# Ensure chosen variant exists and include its configuration
if(NOT EXISTS "${CMAKE_SOURCE_DIR}/variants/${VARIANT}/config.cmake")
    message(FATAL_ERROR "Variant '${VARIANT}' does not exist. Expected file: ${CMAKE_SOURCE_DIR}/variants/${VARIANT}/config.cmake")
endif()
include(${CMAKE_SOURCE_DIR}/variants/${VARIANT}/config.cmake)

if(BUILD_KIT STREQUAL prod)
    project(${VARIANT} C ASM)
    project(${VARIANT} C ASM CXX)
else()
    # C++ project due to GTest usage
    project(${VARIANT} C ASM CXX)
endif()


# Include variant specific parts/components definitions
include(${CMAKE_SOURCE_DIR}/variants/${VARIANT}/parts.cmake)