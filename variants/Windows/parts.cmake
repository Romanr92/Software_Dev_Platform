



# Add component subdirectories to register and collect their sources
sdp_add_component(${CMAKE_SOURCE_DIR}/components/Core_Component)
sdp_add_component(${CMAKE_SOURCE_DIR}/components/C_Components/C_Hello)
sdp_add_component(${CMAKE_SOURCE_DIR}/components/CPP_Components/CPP_Hello)
sdp_add_component(${CMAKE_SOURCE_DIR}/components/Rust_Components/Rust_Hello)

# Collect all component sources from global property
get_property(_component_sources GLOBAL PROPERTY SDP_COMPONENT_SOURCES)
get_property(_component_includes GLOBAL PROPERTY SDP_COMPONENT_INCLUDES)
get_property(_rust_libs GLOBAL PROPERTY SDP_RUST_LIBS)

# Define executable name (can be overridden with -DEXE_NAME=...)
if(NOT DEFINED EXE_NAME)
    set(EXE_NAME "${PROJECT_NAME}")
endif()

message(STATUS "Building executable '${EXE_NAME}' from sources: ${_component_sources}")
message(STATUS "Linking Rust libs: ${_rust_libs}")

# Create the single executable from all collected component sources
add_executable(${EXE_NAME} ${_component_sources})

# Store the executable target globally for components to use
set_property(GLOBAL PROPERTY SDP_EXE_TARGET ${EXE_NAME})

# Configure Rust linking and includes
configure_rust_linking(${EXE_NAME})

# C++ standard
target_compile_features(${EXE_NAME} PRIVATE cxx_std_17)

# Variant-specific definitions
target_compile_definitions(${EXE_NAME}
    PRIVATE
        VARIANT_WINDOWS=1
)

# Output directory for binaries
set_target_properties(${EXE_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

