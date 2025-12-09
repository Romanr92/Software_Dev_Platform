message(STATUS "Configuring targets for Linux variant")

# Add component subdirectories to register and collect their sources
sdp_add_component(${CMAKE_SOURCE_DIR}/components/Core_Component)
sdp_add_component(${CMAKE_SOURCE_DIR}/components/C_Components/C_Hello)
sdp_add_component(${CMAKE_SOURCE_DIR}/components/CPP_Components/CPP_Hello)

# Collect all component sources from global property
get_property(_component_sources GLOBAL PROPERTY SDP_COMPONENT_SOURCES)
get_property(_component_includes GLOBAL PROPERTY SDP_COMPONENT_INCLUDES)

# Define executable name (can be overridden with -DEXE_NAME=...)
if(NOT DEFINED EXE_NAME)
	set(EXE_NAME "${PROJECT_NAME}")
endif()

message(STATUS "Building executable '${EXE_NAME}' from sources: ${_component_sources}")

# Create the single executable from all collected component sources
add_executable(${EXE_NAME} ${_component_sources})

# Include collected component header directories
if(_component_includes)
	target_include_directories(${EXE_NAME} PRIVATE ${_component_includes})
endif()

# Use C++17 for any C++ sources
target_compile_features(${EXE_NAME} PRIVATE cxx_std_17)

# Variant-specific definitions
target_compile_definitions(${EXE_NAME}
	PRIVATE
		VARIANT_LINUX=1
)

# Place binaries into build/bin
set_target_properties(${EXE_NAME} PROPERTIES
	RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)
