sdp_add_source(src/C_hello.c)
sdp_add_required_interface(src/ceva.h)

sdp_add_test_source(test/test_C_Hello.c)

sdp_create_component(LONG_NAME "C Hello Component")