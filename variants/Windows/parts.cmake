# variants/Windows/parts.cmake
#
# "Windows" here is just your variant name, not Microsoft Windows.

message(STATUS "Configuring targets for Windows variant")

# 1) Core library module (component)
# --------------------------------------------------
add_library(core STATIC
    ${CMAKE_SOURCE_DIR}/components/Core_component/src/main.c
    # add more source files for this module here
)

# target_include_directories(core
#     PUBLIC
#         ${CMAKE_SOURCE_DIR}/components/Core_components
# )

# Example of variant-specific compile definitions/options:
target_compile_definitions(core
    PUBLIC
        VARIANT_WINDOWS=1
)

# 2) Main executable for this variant
# --------------------------------------------------
add_executable(${PROJECT_NAME}
    ${CMAKE_SOURCE_DIR}/src/main.c
    # you can add Windows-variant-specific sources here as well
)

# Link the core module into the executable
target_link_libraries(${PROJECT_NAME}
    PRIVATE
        core
)

# Optional: variant-specific definitions for the main executable
target_compile_definitions(${PROJECT_NAME}
    PRIVATE
        VARIANT_WINDOWS=1
)
