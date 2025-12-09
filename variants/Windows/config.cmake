# variants/Windows/config.cmake
#
# Variant-specific configuration for the 'Windows' variant
# (this "Windows" is just your platform name, not Microsoft Windows).

message(STATUS "Configuring variant: Windows")

# Include Rust compiler toolchain
include(${CMAKE_SOURCE_DIR}/tools/RustCompiler/toolchain.cmake)

# Helper function to configure Rust linking for the executable
function(configure_rust_linking exe_target)
    # Link Rust libraries
    get_property(_rust_libs GLOBAL PROPERTY SDP_RUST_LIBS)
    if(_rust_libs)
        target_link_libraries(${exe_target} PRIVATE ${_rust_libs})
        
        # Link Windows libraries required by Rust std
        if(WIN32)
            target_link_libraries(${exe_target} PRIVATE 
                ws2_32       # Winsock
                ntdll        # NT kernel
                userenv      # User environment
                psapi        # Process API
            )
        endif()
    endif()
    
    # Include collected component header directories
    get_property(_component_includes GLOBAL PROPERTY SDP_COMPONENT_INCLUDES)
    if(_component_includes)
        target_include_directories(${exe_target} PRIVATE ${_component_includes})
    endif()
endfunction()

# Example: build-type / kit specific logic (adjust or remove as you like)
if(BUILD_KIT STREQUAL prod)
    message(STATUS "  BUILD_KIT = prod")
else()
    message(STATUS "  BUILD_KIT = ${BUILD_KIT}")
endif()

# ---------------------------------------------------------------------------
# Optional: variant-specific compiler / linker settings
# ---------------------------------------------------------------------------

# Example: common C flags for this variant
# set(VARIANT_C_FLAGS "${CMAKE_C_FLAGS} -Wall")

# Example: set C flags per build type
# set(CMAKE_C_FLAGS_DEBUG   "-O0 -g")
# set(CMAKE_C_FLAGS_RELEASE "-O3")
# set(CMAKE_C_FLAGS         "${VARIANT_C_FLAGS}")

# Example: link options (if you need special link flags for this variant)
# add_link_options(-Wl,--gc-sections)

# ---------------------------------------------------------------------------
# Optional: use a toolchain file (if this variant needs a special compiler)
# ---------------------------------------------------------------------------

# set(CMAKE_TOOLCHAIN_FILE
#     "${CMAKE_SOURCE_DIR}/tools/windows/toolchain.cmake"
# )