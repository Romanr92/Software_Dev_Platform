# sdp helper functions for components

function(sdp_add_source src)
    if(NOT IS_ABSOLUTE "${src}")
        set(_p "${CMAKE_CURRENT_SOURCE_DIR}/${src}")
    else()
        set(_p "${src}")
    endif()
    set_property(GLOBAL APPEND PROPERTY SDP_COMPONENT_SOURCES "${_p}")
    
    # Also append the component's src directory to include paths
    get_filename_component(_dir "${_p}" DIRECTORY)
    set_property(GLOBAL APPEND PROPERTY SDP_COMPONENT_INCLUDES "${_dir}")
endfunction()

function(sdp_add_test_source src)
    if(NOT IS_ABSOLUTE "${src}")
        set(_p "${CMAKE_CURRENT_SOURCE_DIR}/${src}")
    else()
        set(_p "${src}")
    endif()
    set_property(GLOBAL APPEND PROPERTY SDP_COMPONENT_TEST_SOURCES "${_p}")
endfunction()

function(sdp_add_required_interface iface)
    set_property(GLOBAL APPEND PROPERTY SDP_COMPONENT_REQUIRED_INTERFACES "${iface}")
endfunction()

function(sdp_create_component)
    # Usage: sdp_create_component(LONG_NAME "My Component")
    set(_longname "")
    if(ARGC GREATER 1)
        list(GET ARGV 0 key)
        if(key STREQUAL "LONG_NAME")
            list(GET ARGV 1 _longname)
        endif()
    endif()
    if(NOT _longname)
        get_filename_component(_longname ${CMAKE_CURRENT_SOURCE_DIR} NAME)
    endif()
    set(COMPONENT_NAME "${_longname}" CACHE STRING "Name of this component")

    # Compute a safe identifier (replace non-alnum with underscore)
    string(REGEX REPLACE "[^A-Za-z0-9_]" "_" _id "${COMPONENT_NAME}")
    string(SUBSTRING "${_id}" 0 1 _first)
    if(_first MATCHES "[0-9]")
        set(_id "_${_id}")
    endif()
    set(COMPONENT_ID "${_id}" CACHE STRING "Identifier for this component")

    # Record the id for global discovery
    set_property(GLOBAL APPEND PROPERTY SDP_COMPONENT_IDS "${COMPONENT_ID}")

endfunction()

function(sdp_add_component component_path)
    # Add a component subdirectory (e.g., components/Core_Component)
    # This will run the component's CMakeLists.txt and collect its sources.
    # Use a relative build path to avoid nested absolute path issues.
    file(RELATIVE_PATH _rel_path "${CMAKE_SOURCE_DIR}" "${component_path}")
    add_subdirectory(${component_path} ${CMAKE_BINARY_DIR}/${_rel_path})
endfunction()
