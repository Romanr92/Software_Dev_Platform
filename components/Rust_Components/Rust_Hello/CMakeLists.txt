# Compile Rust source to staticlib using toolchain helper
compile_rust_to_object(
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Rust_hello.rs"
    "${CMAKE_BINARY_DIR}/Rust_Hello.a"
    "Rust_hello_obj"
)

sdp_add_test_source(test/test_Rust_hello.rs)

sdp_create_component(LONG_NAME "Rust Hello Component")

