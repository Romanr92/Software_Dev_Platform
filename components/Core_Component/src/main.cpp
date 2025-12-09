#include <iostream>
extern "C" {
    #include "C_hello.h"
    void rust_say_hello();  // Rust function declaration
}
#include "CPP_hello.h"

int main() {

    /* print from main */
    std::cout<< "Hello, Windows!" << std::endl;

    /* Call C code */
    c_say_hello();

    /* Call C++ code */ 
    cpp_say_hello();

    /* Call Rust code */
    rust_say_hello();

    return 0;
}