# variants/Windows/config.cmake
#
# Variant-specific configuration for the 'Windows' variant
# (this "Windows" is just your platform name, not Microsoft Windows).

message(STATUS "Configuring variant: Windows")

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