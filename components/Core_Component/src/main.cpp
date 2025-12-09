#include <iostream>
extern "C" {
    #include "C_hello.h"
}
#include "CPP_hello.h"

int main() {

    /* print from main */
    std::cout<< "Hello, Windows!" << std::endl;

    /* Call C code */
    c_say_hello();

    /* Call C++ code */ 
    cpp_say_hello();

    return 0;
}