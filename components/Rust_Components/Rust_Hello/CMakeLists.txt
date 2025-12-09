# Compile Rust source to staticlib using toolchain helper
compile_rust_to_object(
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Rust_hello.rs"
    "${CMAKE_BINARY_DIR}/Rust_Hello.a"
    "Rust_hello_obj"
)

# Make sure the parent executable depends on Rust compilation
get_property(_exe_target GLOBAL PROPERTY SDP_EXE_TARGET)
if(DEFINED _exe_target AND TARGET Rust_hello_obj)
    add_dependencies(${_exe_target} Rust_hello_obj)
endif()

sdp_add_test_source(test/test_Rust_hello.rs)

sdp_create_component(LONG_NAME "Rust Hello Component")

