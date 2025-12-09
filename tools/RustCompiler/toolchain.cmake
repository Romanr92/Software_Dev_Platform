# Rust Compiler Toolchain
# This toolchain enables Rust compilation in CMake

# Find rustc compiler
find_program(RUSTC_EXECUTABLE NAMES rustc REQUIRED)
message(STATUS "Found rustc: ${RUSTC_EXECUTABLE}")

# Set Rust target based on platform
if(WIN32)
    set(RUST_TARGET "x86_64-pc-windows-gnu" CACHE STRING "Rust target triple")
else()
    set(RUST_TARGET "x86_64-unknown-linux-gnu" CACHE STRING "Rust target triple")
endif()

message(STATUS "Rust target: ${RUST_TARGET}")

# Helper function to compile Rust source to staticlib  
function(compile_rust_to_object rust_src output_obj target_name)
    # Usage: compile_rust_to_object(src/lib.rs ${CMAKE_BINARY_DIR}/lib.a rust_lib_obj)
    # Note: This now builds a static library instead of object files
    
    # Extract crate name from output parameter (used to name the library)
    get_filename_component(_output_name "${output_obj}" NAME_WE)
    string(REPLACE "lib" "" _crate_name "${_output_name}")
    
    add_custom_command(
        OUTPUT "${output_obj}"
        COMMAND ${RUSTC_EXECUTABLE}
            --edition 2021
            -C opt-level=3
            -C panic=abort
            --emit=link
            --crate-type staticlib
            --target ${RUST_TARGET}
            -L "${CMAKE_BINARY_DIR}/deps"
            -o "${output_obj}"
            "${rust_src}"
        DEPENDS "${rust_src}"
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
        COMMENT "Compiling Rust staticlib ${rust_src} to ${output_obj}"
    )
    
    # Create a custom target for the Rust library
    add_custom_target(${target_name} ALL DEPENDS "${output_obj}")
    
    # Register the static library with global property for linking
    set_property(GLOBAL APPEND PROPERTY SDP_RUST_LIBS "${output_obj}")
endfunction()
